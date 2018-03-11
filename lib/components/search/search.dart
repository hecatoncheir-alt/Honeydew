library search;

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';

import 'package:honeydew/services.dart' show SocketService;

@Component(
    selector: 'search',
    templateUrl: 'search.html',
    directives: const [MaterialAutoSuggestInputComponent],
    providers: const [SocketService, materialProviders])
class SearchComponent implements OnActivate {
  List<String> suggestions = new List<String>();
  SocketService socket;

  SearchComponent(this.socket);

  String searchFor = "Товары";

  @override
  Future onActivate(_, RouterState state) async {
    print("search component active");
    print(state.routePath.path);
  }
}
