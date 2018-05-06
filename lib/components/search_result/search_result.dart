library search_result;

import 'dart:async';

import 'package:uuid/uuid.dart';
import 'package:angular/angular.dart';

import 'package:honeydew/components.dart' show Table;
import 'package:honeydew/entities.dart'
    show Product, Company, Price, Column, Row, Cell;

@Component(
    selector: 'search-result',
    templateUrl: 'search_result.html',
    directives: const [Table])
class SearchResultComponent extends OnChanges {
  @Input()
  List<Product> products;

  List<Column> columns;
  List<Row> rows;

  void ngOnChanges(Map<String, SimpleChange> changeRecord) {
    if (changeRecord["products"].previousValue !=
        changeRecord["products"].currentValue) {
      prepareColumns(changeRecord["products"].currentValue)
          .then((List<Column> columns) => this.columns = columns);

      prepareRows(changeRecord['products'].currentValue)
          .then((List<Row> rows) => this.rows = rows);
    }
  }

  Future<List<Column>> prepareColumns(List<Product> products) async {
    return prepareCompaniesOfProducts(products).then((List<Company> companies) {
      List<Column> columns = new List<Column>();

      String uidOfProductNameColumn = new Uuid().v4();
      Column columnOfProductName = new Column(
          uid: uidOfProductNameColumn, title: "Продукт", field: "productName");
      columns.add(columnOfProductName);

      for (Company company in companies) {
        Column companyColumn = new Column(
            uid: company.uid,
            title: company.companyName,
            field: company.companyName);
        columns.add(companyColumn);
      }

      return columns;
    });
  }

  Future<List<Company>> prepareCompaniesOfProducts(
      List<Product> products) async {
    List<Company> companiesOfProductsPrices = new List<Company>();
    for (Product product in products) {
      for (Price price in product.hasPrice) {
        for (Company company in price.belongsToCompany) {
          if (companiesOfProductsPrices.contains(company)) continue;
          companiesOfProductsPrices.add(company);
        }
      }
    }

    return companiesOfProductsPrices;
  }

  Future<List<Row>> prepareRows(List<Product> products) async {
    List<Row> rows = new List<Row>();

    for (Product product in products) {
      List<Cell> cells = new List<Cell>();

      Cell cellOfProductName = new Cell(
          uid: product.uid,
          field: "productName",
          value: product.productName,
          rowId: product.uid);

      cells.add(cellOfProductName);

      for (Price price in product.hasPrice) {
        Cell cell = new Cell(
            uid: price.uid,
            rowId: product.uid,
            field: price.belongsToCompany.first.companyName,
            value: price.priceValue.toString());
        cells.add(cell);
      }

      Row row = new Row(uid: product.uid, cells: cells);
      rows.add(row);
    }

    return rows;
  }
}
