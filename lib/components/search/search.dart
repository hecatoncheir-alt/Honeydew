library search;

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:honeydew/services.dart' show SocketService;

class SearchParams {
  String text;
}

@Component(
    selector: 'search',
    templateUrl: 'search.html',
    styleUrls: ["search.css"],
    providers: const [SocketService])
class SearchComponent implements OnActivate {
  SocketService socket;

  int countOfResults;
  String searchValue;
  SearchParams searchParams;

  SearchComponent(this.socket) : searchParams = new SearchParams();

  @override
  Future onActivate(_, RouterState routerState) async {
    print(routerState.routePath.path);
  }

  void search(SearchParams params) {
    print(params.text);
  }
}
