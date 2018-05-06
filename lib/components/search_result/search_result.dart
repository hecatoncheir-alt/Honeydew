library search_result;

import 'dart:async';

import 'package:angular/angular.dart';

import 'package:honeydew/entities.dart'
    show Product, Company, Price, Column, Row;

@Component(
    selector: 'search-result',
    templateUrl: 'search_result.html',
    styleUrls: ["search_result.css"])
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
    }
  }

  Future<List<Column>> prepareColumns(List<Product> products) async {
    //TODO
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
}
