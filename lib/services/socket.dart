library socket_service;

import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:honeydew/services.dart' show ConfigurationService;

import 'package:honeydew/entities.dart' show EventData;

@Injectable()
class SocketService {
  WebSocket
      socketConnection; // Подключение куда отправляются события и откуда приходят

  List eventPool = new List();

  /// Позволяет определить установлено ли соединение
  /// с сервером в случаи разрыва или нет.
  bool reconnectionInProgress = false;

  StreamController<EventData> dataControl = new StreamController<EventData>();

  Stream<EventData> data;

  String protocol, host;
  int port;

  ConfigurationService configurationService;

  /// Конструктор сервиса
  SocketService(this.configurationService) {
    data = dataControl.stream.asBroadcastStream();
  }

  /// Подключение к серверу
  void connect({String protocol: "ws", String host, int port}) {
    this
      ..protocol = protocol
      ..host = host
      ..port = port;

    try {
      String iri = "$protocol://$host:$port/";

      /// Подключение к socket серверу
      socketConnection = new WebSocket(iri);
      print("Socket connection in progress");

      socketConnection.onOpen.listen((Event event) {
        /// Если подключение осуществлялось в случаи разрыва соединения
        /// нужно отправить уведомление об успешном переподключении.
        if (reconnectionInProgress == true) {
          print("Client reconnected to server");

          /// После подключения к серверу, если есть не отправленные события
          /// их нужно отправить.
          if (eventPool.isNotEmpty) {
            for (EventData eventData in eventPool) {
              socketConnection.send(eventData);
            }
          }

          // Отправление уведомления об успешном переподключении
          dataControl.add(new EventData("Client reconnected to server"));
        }

        reconnectionInProgress = false;
        print("Socket connected to server");
      });

      /// После подключения к socket серверу
      /// нужно подписаться на события приходящие с сервера.
      subscribeToEvents(socketConnection.onMessage);

      /// При закрытии соединения, нужно оповестить об этом
      /// другие компоненты. И начать подключение заново.
      socketConnection.onClose.listen((_) {
        dataControl.add(new EventData("Connection closed"));
        print("Socket connection is closed");

        /// В случае разрыва соединения необходимо осуществить попытку
        /// установления связи с сервером повторно.
        reconnect(durationInSeconds: 3);
      });
    } catch (err) {
      print(err);
    }
  }

  /// Метод закрытия соеднинения с socket сервером
  Future<Null> connectionClose() async {
    try {
      socketConnection.close();
    } catch (error) {
      print(error);
    }
  }

  /// Через каждые 3 секунды (по умолчанию) клиент предпринимает
  /// попытки восстановить соединение.
  /// Подробнее: при подключении, если сервер будет не доступен, socketConnection
  /// обработает событие onClose где вновь будет вызван метод reconnect.
  void reconnect({int durationInSeconds: 3}) {
    new Timer(
        new Duration(seconds: durationInSeconds),
        () =>
            connect(protocol: this.protocol, host: this.host, port: this.port));
    reconnectionInProgress = true;
  }

  /// Метод который подписывается на stream событий от сервера
  Future<Null> subscribeToEvents(Stream eventChannel) async {
    eventChannel.listen((event) {
      _decodeSocketData(event).then(_finalizeData);
    });
  }

  /// Отправляя событие с клиента на сервер нужно убедиться в том что клиент
  /// подключен к socket серверу.
  /// Функция которая ожидает подключения к socket серверу перед тем как
  /// отправить событие.
  void waitForSocketConnection(
      WebSocket socket, EventData eventData, int iterator) {
    if (iterator != 0) {
      iterator--;
      // Используется таймер
      new Timer(new Duration(seconds: 1), () {
        if (socket != null && socket.readyState == 1) {
          eventData.APIVersion = configurationService.config.apiVersion;

          /// Событие необходимо добавить в общий пул событий.
          /// Это позволит в случае разъединения отправить событие на сервер
          /// повторно при подключении.
          String encodedData = json.encode(eventData);

          /// Когда подключение к серверу будет установлено,
          /// сообщение будет отправлено.
          socket.send(encodedData);

          /// В случае успешной отправки события на сервер
          /// его можно удалять из списка не отправленных событий.
          eventPool.remove(eventData);
        } else {
          print("Wait for connection... Attempt: $iterator");

          /// Если подключение к socket серверу еще в процессе
          /// по окончании времени используется рекурсивный вызов функции
          /// до тех пор пока подключение не будет установлено.
          waitForSocketConnection(socket, eventData, iterator);
        }
      });
    } else {
      print("Socket must be reconnected");
    }
  }

  /// Метод для отправки событий на сервер
  Future<Null> write(EventData message) async {
    /// Событие необходимо добавить в общий пул событий.
    /// Это позволит в случае разъединения отправить событие на сервер
    /// повторно при подключении.
    eventPool.add(message);

    /// Перед отправкой сообщения нужно убедиться в том, что
    /// связь с socket сервером установлена.
    /// Последним параметром указывается количество секунд ожидания
    /// соединения.
    if (this.socketConnection == null) {
      new Future(
          () => waitForSocketConnection(this.socketConnection, message, 5));
    } else {
      waitForSocketConnection(this.socketConnection, message, 5);
    }
  }

  /// Получая событие от сервера нужно JSON строку разобрать в
  /// Map структуру.
  /// В stream приходит MessageEvent объект.
  /// Метод может разобрать как строку так и событие которое
  /// содержит в себе строку. Это делает метод более универсальным,
  /// и позволяет проще реализовать Mock сервиса.
  Future<EventData> _decodeSocketData(MessageEvent event) async {
    Map<String, dynamic> details;

    details = json.decode(event.data);

    if (details["APIVersion"] != configurationService.config.apiVersion)
      return null;

    EventData data = new EventData(
        details["Message"], details["Data"], details["APIVersion"]);

    return data;
  }

  /// После того как данные о событии с сервера будут представлены
  /// в виде структуры Map, их можно отправлять в поток событий: data,
  /// на который подписывaются остальные сервисы и компоненты.
  void _finalizeData(EventData socketData) {
    if (socketData != null) dataControl.add(socketData);
  }
}
