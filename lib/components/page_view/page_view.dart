library page_view_component;

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:honeydew/services.dart' as services;

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
      const ClassProvider(services.SocketService),
      const ClassProvider(services.ConfigurationService),
      const ClassProvider(services.Routes)
    ])
class PageViewComponent extends OnInit {
  final services.SocketService socketService;
  final services.ConfigurationService configuration;
  final services.Routes routes;

  PageViewComponent(this.socketService, this.configuration, this.routes);

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
