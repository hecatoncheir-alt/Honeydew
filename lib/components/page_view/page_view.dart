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
      routerProvidersHash,
    ])
class PageViewComponent extends OnInit {
  services.SocketService socketService;
  services.ConfigurationService configuration;

  final Router router;

  static final searchRoute = new RoutePath(path: "search", useAsDefault: true);

  final List<RouteDefinition> routes = [
    new RouteDefinition.redirect(path: '', redirectTo: "search"),
    new RouteDefinition(
        path: 'search',
        routePath: searchRoute,
        component: templates.SearchComponentNgFactory,
        useAsDefault: true),
  ];

  PageViewComponent(this.socketService, this.configuration, this.router);

  @override
  void ngOnInit() {
    // configuration
    //     .getConfiguration(window.location)
    //     .then((services.Configuration config) {
    //   socketService.connect(
    //       protocol: config.socket.protocol,
    //       host: config.socket.host,
    //       port: config.socket.port);
    // });
  }
}
