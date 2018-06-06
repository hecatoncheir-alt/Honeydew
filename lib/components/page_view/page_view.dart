library page_view_component;

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:honeydew/services.dart' as services;

@Component(
    selector: 'page-view',
    templateUrl: 'page_view.html',
    styleUrls: const ['page_view.css'],
    directives: const [routerDirectives])
class PageViewComponent {
  final services.Routes routes;

  PageViewComponent(this.routes);
}
