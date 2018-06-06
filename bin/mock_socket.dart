library mock_socket;

import 'dart:io';
import 'dart:convert';

import 'package:honeydew/entities.dart' show EventData;

void main() {
  int port = 81;

  HttpServer.bind(InternetAddress.loopbackIPv4, port).then((HttpServer server) {
    print("Server is running on "
        "'http://${server.address.address}:$port/'");

    server.transform(new WebSocketTransformer()).listen((WebSocket socket) {
      socket
          .map((data) => new EventData.from(json.decode(data)))
          .listen((EventData eventData) {
//        {
//          Message:Need items by name,
//              Data:{
//        "SearchedName":"sum",
//        "CurrentPage":1,
//        "Tot
//        alProductsForOnePage":1,
//        "Language":"ru"
//        },
//        APIVersion:1.0   .0
//        }
        if (eventData.message == "Need items by name") {
          EventData event = new EventData("Items by name ready");
          event.APIVersion = eventData.APIVersion;
          socket.add(json.encode(event));
        }
      });
    });
  });
}
