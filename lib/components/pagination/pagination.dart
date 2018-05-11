library pagination;

import 'dart:async';
import 'package:angular/angular.dart';

@Component(selector: 'pagination', templateUrl: 'pagination.html')
class PaginationComponent {
  @Output()
  get selectedPage => _currentSelectedPageNumber.stream;
  final _currentSelectedPageNumber = new StreamController<int>();

  @Input()
  int currentPage;

  @Input()
  int totalItems;

  @Input()
  int itemsPerPage;
}
