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

  Future<void> sendRequest(SearchParams params) async {}

  void search(SearchParams params) {
    if (params.currentPage == null) {
      router.navigate("//search/${params.text}/page/1");
    } else {
      router.navigate("//search/${params.text}/page/${params.currentPage}");
    }
  }
}
