library honeydew;

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:honeydew/components/page_view/page_view.template.dart'
    as page_view;

import 'main.template.dart' as self;

import 'package:honeydew/services.dart' as services;

@GenerateInjector(const [
  routerProvidersHash,
  services.SocketService,
  services.ConfigurationService,
  services.Routes
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  runAppAsync(page_view.PageViewComponentNgFactory,
      createInjector: injector, beforeComponentCreated: prepareServices);
}

Future<void> prepareServices(Injector injector) async {
  services.ConfigurationService configuration =
      injector.get(services.ConfigurationService);

  await configuration.getConfiguration(window.location);

  services.SocketService socket = injector.get(services.SocketService);

  socket.connect(
      protocol: configuration.config.socket.protocol,
      host: configuration.config.socket.host,
      port: configuration.config.socket.port);
}
