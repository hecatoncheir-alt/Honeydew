library search;

import 'dart:async';

import 'dart:collection';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:honeydew/services.dart' show SocketService, SocketMessageFormat;

class SearchParams extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get text => this['text'];
  set text(String value) => this['text'] = value;

  int get currentPage => this['currentPage'];
  set currentPage(int value) => this['currentPage'] = value;

  int get resultsOnOnePage => this['resultsOnOnePage'];
  set resultsOnOnePage(int value) => this['resultsOnOnePage'] = value;

  SearchParams({String text, int currentPage, int resultsOnOnePage}) {
    this["text"] = text;
    this["currentPage"] = currentPage;
    this["resultsOnOnePage"] = resultsOnOnePage;
  }

  operator [](Object key) => _entityMap[key];
  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);
  clear() => _entityMap.clear();
}

@Component(
    selector: 'search',
    templateUrl: 'search.html',
    styleUrls: ["search.css"],
    providers: const [SocketService])
class SearchComponent implements OnActivate {
  SocketService socket;

  int countOfResults;
  SearchParams searchParams;

  Router router;

  SearchComponent(this.socket, this.router)
      : searchParams = new SearchParams()..resultsOnOnePage = 10;

  @override
  Future onActivate(_, RouterState newRouterState) async {
    searchParams.text = newRouterState.parameters["text"];

    if (newRouterState.parameters["page"] != null)
      searchParams.currentPage = int.parse(newRouterState.parameters["page"]);

    if (searchParams.currentPage == null && searchParams.text != null)
      router.navigate("//search/${searchParams.text}/page/1");

    if (searchParams.currentPage != null && searchParams.text != null)
      this.sendRequest(this.searchParams);
  }

  Future<void> sendRequest(SearchParams params) async {
    SocketMessageFormat message = new SocketMessageFormat(
        "Need items by name", params as Map<String, dynamic>);
    socket.write(message);
  }

  void search(SearchParams params) {
    if (params.currentPage == null) {
      router.navigate("//search/${params.text}/page/1");
    } else {
      router.navigate("//search/${params.text}/page/${params.currentPage}");
    }
  }
}
