library honeydew;

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
  runApp(page_view.PageViewComponentNgFactory, createInjector: injector);
}
