library page_view_component;

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:honeydew/services.dart' as services;
import '../search/search.template.dart' as templates;

@Component(
    selector: 'page-view',
    templateUrl: 'page_view.html',
    styleUrls: const [
      'page_view.css'
    ],
    directives: const [
      routerDirectives
    ],
    providers: const [
      services.SocketService,
      services.ConfigurationService,
      routerProviders
    ])
class PageViewComponent extends OnInit {
  static final mainRoute = new RoutePath(
    path: "/",
    useAsDefault: true,
  );

  services.SocketService socketService;
  services.ConfigurationService configuration;

  final Router router;

  final List<RouteDefinition> routes = [
    new RouteDefinition(
      routePath: mainRoute,
      component: templates.SearchComponentNgFactory,
    ),
  ];

  PageViewComponent(this.socketService, this.configuration, this.router);

  @override
  void ngOnInit() {
    configuration
        .getConfiguration(window.location)
        .then((services.Configuration config) {
      socketService.connect(
          protocol: config.socket.protocol,
          host: config.socket.host,
          port: config.socket.port);
    });
  }
}
