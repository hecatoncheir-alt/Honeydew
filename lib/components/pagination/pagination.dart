library pagination;

import 'dart:async';
import 'package:angular/angular.dart';

@Component(
    selector: 'pagination',
    templateUrl: 'pagination.html',
    styleUrls: const ['pagination.css'],
    directives: const [NgIf])
class PaginationComponent {
  @Output()
  get selectedPage => _currentSelectedPageNumber.stream;
  final _currentSelectedPageNumber = new StreamController<int>();

  void selectPage(int pageNumber) =>
      this._currentSelectedPageNumber.add(pageNumber);

  @Input()
  int currentPage;

  @Input()
  int totalItems;

  int _itemsPerPage;
  int get itemsPerPage => _itemsPerPage;

  @Input()
  set itemsPerPage(int perPageItems) {
    this
      .._itemsPerPage = perPageItems
      ..totalPages = preparePagesCount(
          itemsCount: this.totalItems, perPageItemsCount: this.itemsPerPage);
  }

  int totalPages;

  /// Возарщает количество страниц
  int preparePagesCount({int itemsCount, int perPageItemsCount}) {
    /// Всего целых страниц полностью заполненных записями
    int countPages = itemsCount ~/ perPageItemsCount;

    try {
      /// Записей может быть меньше чем на целую страницу
      double remainingRowsCount = (itemsCount / perPageItemsCount) *
          itemsCount %
          itemsCount /
          itemsCount;

      /// Если записи есть в остатке то нужно добавить одну страницу
      /// для их отображения
      if (remainingRowsCount > 0) {
        countPages += 1;
      }
    } catch (err) {
      print("preparePagesCount error: $err");
    }

    return countPages;
  }
}
