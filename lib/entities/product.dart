library product_entity;

import 'dart:collection';

import 'price.dart';
import 'company.dart';
import 'category.dart';

class Product extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get uid => this['uid'];
  set uid(String value) => this['uid'] = value;

  String get productName => this['productName'];
  set productName(String value) => this['productName'] = value;

  bool get productIsActive => this._entityMap['productIsActive'];
  set productIsActive(bool value) => this['productIsActive'] = value;

  List<Price> get hasPrice => this['has_price'];
  set hasPrice(List<Price> value) => this['has_price'] = value;

  List<Category> get belongsToCategory => this['belongs_to_category'];
  set belongsToCategory(List<Category> value) =>
      this['belongs_to_category'] = value;

  List<Company> get belongsToCompany => this['belongs_to_company'];
  set belongsToCompany(List<Company> value) =>
      this['belongs_to_company'] = value;

  Product(
      {String uid,
      String productName,
      List<Price> hasPrice,
      List<Company> belongsToCompany,
      List<Category> belongsToCategory,
      bool productIsActive}) {
    this["uid"] = uid;
    this["productName"] = productName;
    this["productIsActive"] = productIsActive;
    this
      ..belongsToCategory = belongsToCategory
      ..belongsToCompany = belongsToCompany;
  }

  Product.fromMap(Map map) {
    this._entityMap = map;

    List<Price> prices = new List<Price>();
    if (map["has_price"] != null) {
      for (Map price in map["has_price"]) {
        prices.add(new Price.fromMap(price));
      }
    }

    _entityMap["has_price"] = prices;

    List<Company> companies = new List<Company>();
    if (map["belongs_to_company"] != null) {
      for (Map company in map["belongs_to_company"]) {
        companies.add(new Company.fromMap(company));
      }
    }

    _entityMap["belongs_to_company"] = companies;

    List<Category> categories = new List<Category>();
    if (map["belongs_to_category"] != null) {
      for (Map category in map["belongs_to_category"]) {
        categories.add(new Category.fromMap(category));
      }
    }

    _entityMap["belongs_to_category"] = categories;
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}
