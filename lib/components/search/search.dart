library search;

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(selector: 'search', templateUrl: 'search.html')
class SearchComponent implements OnActivate {
  @override
  Future onActivate(_, __) async {
    print("search component active");
  }
}
