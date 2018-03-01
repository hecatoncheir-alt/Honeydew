library honeydew;

import 'package:angular/angular.dart';
import 'package:honeydew/components.dart';

import 'main.template.dart' as ng;

void main(){
  bootstrapStatic(PageViewComponent,[], ng.initReflector);
}