library search;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:honeydew/services.dart' show SocketService, EventData;

class SearchParams extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get Language => this['Language'];

  set Language(String value) => this['Language'] = value;

  String get SearchedName => this['SearchedName'];

  set SearchedName(String value) => this['SearchedName'] = value;

  int get CurrentPage => this['CurrentPage'];

  set CurrentPage(int value) => this['CurrentPage'] = value;

  int get CountProductsOnPage => this['CountProductsOnPage'];

  set CountProductsOnPage(int value) => this['CountProductsOnPage'] = value;

  SearchParams(
      {String SearchedName, int CurrentPage, int CountProductsOnPage}) {
    this["SearchedName"] = SearchedName;
    this["CurrentPage"] = CurrentPage;
    this["CountProductsOnPage"] = CountProductsOnPage;
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}

@Component(
    selector: 'search', templateUrl: 'search.html', styleUrls: ["search.css"])
class SearchComponent implements OnActivate {
  SocketService socket;

  int countOfResults;
  SearchParams searchParams;

  Router router;

  SearchComponent(this.socket, this.router)
      : searchParams = new SearchParams()
          ..CountProductsOnPage = 10
          ..Language = "ru" {
    socket.data.listen((e) {
      print(e);
    });
  }

  @override
  Future onActivate(_, RouterState newRouterState) async {
    searchParams.SearchedName = newRouterState.parameters["text"];

    if (newRouterState.parameters["page"] != null)
      searchParams.CurrentPage = int.parse(newRouterState.parameters["page"]);

    if (searchParams.CurrentPage == null && searchParams.SearchedName != null)
      router.navigate("//search/${searchParams.SearchedName}/page/1");

    if (searchParams.CurrentPage != null && searchParams.SearchedName != null)
      this.sendRequest(this.searchParams);
  }

  Future<void> sendRequest(SearchParams params) async {
    String encodedParams = json.encode(params);
    EventData message = new EventData("Need items by name", encodedParams);
    socket.write(message);
  }

  void search(SearchParams params) {
    if (params.CurrentPage == null) {
      router.navigate("//search/${params.SearchedName}/page/1");
    } else {
      router.navigate(
          "//search/${params.SearchedName}/page/${params.CurrentPage}");
    }
  }
}
