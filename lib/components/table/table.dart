library table;

import 'package:angular/angular.dart';

import 'package:honeydew/entities.dart' show Column, Row;

@Component(
    selector: 'table',
    templateUrl: 'table.html',
    styleUrls: ["table.css"],
    directives: const [NgFor, NgIf])
class Table extends OnChanges {
  @Input()
  List<Column> columns;

  @Input()
  List<Row> rows;

  @Input()
  String height;

  void ngOnChanges(Map<String, SimpleChange> changeRecord) {
//    if (changeRecord["columns"].previousValue !=
//        changeRecord["columns"].currentValue) {}
//
//    if (changeRecord["rows"].previousValue !=
//        changeRecord["rows"].currentValue) {}
  }

  Column columnTrack(int index, dynamic item) {
    return columns[index];
  }

  Row rowTrack(int index, dynamic item) {
    return rows[index];
  }
}
