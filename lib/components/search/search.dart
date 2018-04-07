library search;

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:honeydew/services.dart' show SocketService;

class SearchParams {
  String text;
  int currentPage, resultsOnOnePage;
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

  SearchComponent(this.socket, this.router) : searchParams = new SearchParams();

  @override
  Future onActivate(_, RouterState newRouterState) async {
    print(newRouterState..parameters);
    searchParams.text = newRouterState.parameters["text"];
  }

  void search(SearchParams params) {
    print(params.text);
    print("-");
    router.navigate("//search/${params.text}");
  }
}
