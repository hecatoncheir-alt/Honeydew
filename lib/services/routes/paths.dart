import 'package:angular_router/angular_router.dart';

final RoutePath search = RoutePath(path: "search", useAsDefault: true);

final RoutePath searchWithParams = new RoutePath(path: 'search/:text');

final RoutePath searchWithPageParams =
    new RoutePath(path: 'search/:text/page/:page');
