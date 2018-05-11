library table;

import 'package:angular/angular.dart';

import 'package:honeydew/entities.dart' show Column, Row;

@Component(
    selector: 'table',
    templateUrl: 'table.html',
    styleUrls: const ["table.css"],
    directives: const [NgFor, NgIf])
class TableComponent {
  @Input()
  List<Column> columns;

  @Input()
  List<Row> rows;

  @Input()
  String height;

  Column columnTrack(int index, dynamic item) {
    return columns[index];
  }

  Row rowTrack(int index, dynamic item) {
    return rows[index];
  }
}
