library category_entity;

import 'dart:collection';

import 'company.dart' show Company;
import 'product.dart' show Product;

class Category extends MapBase {
  Map<String, dynamic> entity = new Map<String, dynamic>();

  String get uid => this['uid'];
  set uid(String value) => this['uid'] = value;

  String get categoryName => this['categoryName'];
  set categoryName(String value) => this['categoryName'] = value;

  bool get categoryIsActive => this.entity['categoryIsActive'];
  set categoryIsActive(bool value) => this['categoryIsActive'] = value;

  List<Product> get hasProduct => this['has_product'];
  set hasProduct(List<Product> value) => this['has_product'] = value;

  List<Company> get belongsToCompany => this['belongs_to_company'];
  set belongsToCompany(List<Company> value) =>
      this['belongs_to_company'] = value;

  Product(
      {String uid,
      String categoryName,
      List<Product> hasProduct,
      List<Company> belongsToCompany,
      bool categoryIsActive}) {
    this["uid"] = uid;
    this["categoryName"] = categoryName;
    this["categoryIsActive"] = categoryIsActive;
    this
      ..belongsToCompany = belongsToCompany
      ..hasProduct = hasProduct;
  }

  Category.fromMap(Map map) {
    this.entity = map;

    List<Product> entities = new List<Product>();
    if (map["has_product"] != null) {
      for (Map entity in map["has_product"]) {
        entities.add(new Product.fromMap(entity));
      }
    }

    entity["has_product"] = entities;

    List<Company> companies = new List<Company>();
    if (map["belongs_to_company"] != null) {
      for (Map entity in map["belongs_to_company"]) {
        companies.add(new Company.fromMap(entity));
      }
    }

    entity["belongs_to_company"] = companies;
  }

  operator [](Object key) => entity[key];

  operator []=(dynamic key, dynamic value) => entity[key] = value;

  get keys => entity.keys;

  remove(key) => entity.remove(key);

  clear() => entity.clear();
}
