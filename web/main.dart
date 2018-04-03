library honeydew;

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:honeydew/components.dart' show PageViewComponent;
import 'package:honeydew/components/page_view/page_view.template.dart'
    as page_view;

void main() {
  bootstrapStatic(
      PageViewComponent, [routerProvidersHash], page_view.initReflector);
}
