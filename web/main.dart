library honeydew;

import 'package:angular/angular.dart';
import 'package:angular/experimental.dart';
import 'package:angular_router/angular_router.dart';

import 'package:honeydew/components/page_view/page_view.template.dart' as page_view;
import 'main.template.dart' as template;

@GenerateInjector(const [routerProviders])
final InjectorFactory mainInjector = template.mainInjector$Injector;
void main() {
  bootstrapFactory(
    page_view.PageViewComponentNgFactory,
    mainInjector,
  );
}
