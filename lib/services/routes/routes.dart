library routes;

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../../components/search/search.template.dart' as searchTemplate;
import 'paths.dart' as paths;

@Injectable()
class Routes {
  static final _main =
      new RouteDefinition.redirect(path: '/', redirectTo: _search.toUrl());
  RouteDefinition get main => _main;

  static final _search = new RouteDefinition(
      routePath: paths.search,
      component: searchTemplate.SearchComponentNgFactory);
  RouteDefinition get search => _search;

  static final _searchWithParams = new RouteDefinition(
      routePath: paths.searchWithParams,
      component: searchTemplate.SearchComponentNgFactory);
  RouteDefinition get searchWithParams => _searchWithParams;

  static final _searchWithPageParams = new RouteDefinition(
      routePath: paths.searchWithPageParams,
      component: searchTemplate.SearchComponentNgFactory);
  RouteDefinition get searchWithPageParams => _searchWithPageParams;

  final List<RouteDefinition> all = [
    _main,
    _search,
    _searchWithParams,
    _searchWithPageParams
  ];
}
