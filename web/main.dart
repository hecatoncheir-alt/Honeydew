library honeydew;

import 'package:angular/angular.dart';
import 'package:honeydew/components.dart';

import 'main.template.dart' as template;

void main() {
  bootstrapStatic(PageViewComponent, [], template.initReflector);
}
