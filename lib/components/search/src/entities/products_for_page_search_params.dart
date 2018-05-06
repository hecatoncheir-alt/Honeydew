library products_for_page_search_params_entity;

import 'dart:collection';

class ProductsForPageSearchParams extends MapBase {
  Map<String, dynamic> entityMap = new Map<String, dynamic>();

  String get Language => this['Language'];
  set Language(String value) => this['Language'] = value;

  String get SearchedName => this['SearchedName'];
  set SearchedName(String value) => this['SearchedName'] = value;

  int get CurrentPage => this['CurrentPage'];
  set CurrentPage(int value) => this['CurrentPage'] = value;

  int get CountProductsOnPage => this['CountProductsOnPage'];
  set CountProductsOnPage(int value) => this['CountProductsOnPage'] = value;

  ProductsForPageSearchParams(
      {String SearchedName, int CurrentPage, int CountProductsOnPage}) {
    this["SearchedName"] = SearchedName;
    this["CurrentPage"] = CurrentPage;
    this["CountProductsOnPage"] = CountProductsOnPage;
  }

  operator [](Object key) => entityMap[key];

  operator []=(dynamic key, dynamic value) => entityMap[key] = value;

  get keys => entityMap.keys;

  remove(key) => entityMap.remove(key);

  clear() => entityMap.clear();
}
