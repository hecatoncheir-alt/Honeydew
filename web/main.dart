library honeydew;

import 'package:angular/experimental.dart';
import 'package:honeydew/components/page_view/page_view.template.dart' as page_view;

void main() {
  bootstrapFactory(page_view.PageViewComponentNgFactory);
}
