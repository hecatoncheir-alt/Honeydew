library routes;

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../components/search/search.template.dart' as templates;

final RoutePath search = RoutePath(path: "search", useAsDefault: true);
final RoutePath searchWithParams =
    new RoutePath(path: 'search/:text', parent: search);
final RoutePath searchWithPageParams =
    new RoutePath(path: 'search/:text/page/:page', parent: searchWithParams);

@Injectable()
class Routes {
  final List<RouteDefinition> all = [
    new RouteDefinition.redirect(path: '/', redirectTo: "//search"),
    new RouteDefinition(
        routePath: search, component: templates.SearchComponentNgFactory),
    new RouteDefinition(
        routePath: searchWithParams,
        component: templates.SearchComponentNgFactory),
    new RouteDefinition(
        routePath: searchWithPageParams,
        component: templates.SearchComponentNgFactory)
  ];
}
