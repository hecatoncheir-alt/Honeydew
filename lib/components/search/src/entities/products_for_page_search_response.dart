library products_for_page_search_esponse_entity;

import 'products_for_page_search_params.dart';
import 'package:honeydew/entities.dart' show Product;

class ProductsForPageSearchResponse extends ProductsForPageSearchParams {
  Map<String, dynamic> get entityMap => super.entityMap;
  set entityMap(Map<String, dynamic> map) => super.entityMap = map;

  ProductsForPageSearchResponse(
      {String SearchedName,
      int CurrentPage,
      int CountProductsOnPage,
      int TotalProductsFound,
      int TotalProductsOnOnePage}) {
    super.SearchedName = SearchedName;
    super.CurrentPage = CurrentPage;
    super.CountProductsOnPage = CountProductsOnPage;

    this
      ..TotalProductsFound = TotalProductsFound
      ..TotalProductsOnOnePage = TotalProductsOnOnePage
      ..Products = new List<Product>();
  }

  ProductsForPageSearchResponse.fromMap(Map<String, dynamic> map) {
    entityMap = map;
    List<Product> products = new List<Product>();
    for (Map product in map["Products"]) {
      products.add(new Product.fromMap(product));
    }

    entityMap["Products"] = products;
  }

  int get TotalProductsOnOnePage => this['TotalProductsOnOnePage'];
  set TotalProductsOnOnePage(int value) =>
      this['TotalProductsOnOnePage'] = value;

  int get TotalProductsFound => this['TotalProductsFound'];
  set TotalProductsFound(int value) => this['TotalProductsFound'] = value;

  String get SearchedName => this['SearchedName'];
  set SearchedName(String value) => this['SearchedName'] = value;

  List<Product> get Products => this['Products'];
  set Products(List<Product> value) => this['Products'] = value;
}
