library category_entity;

import 'dart:collection';

import 'company.dart' show Company;
import 'product.dart';
import 'price.dart';

class Category extends MapBase {
  Map<String, dynamic> entity = new Map<String, dynamic>();

  String get uid => this['uid'];
  set uid(String value) => this['uid'] = value;

  String get name => this['categoryName'];
  set name(String value) => this['categoryName'] = value;

  bool get isActive => this.entity['categoryIsActive'];
  set isActive(bool value) => this['categoryIsActive'] = value;

  List<ProductOfCategory> get hasProduct => this['has_product'];
  set hasProduct(List<ProductOfCategory> value) => this['has_product'] = value;

  List<Company> get belongsToCompany => this['belongs_to_company'];
  set belongsToCompany(List<Company> value) =>
      this['belongs_to_company'] = value;

  Product(
      {String uid,
      String categoryName,
      List<ProductOfCategory> hasProduct,
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

    List<ProductOfCategory> entities = new List<ProductOfCategory>();
    if (map["has_product"] != null) {
      for (Map entity in map["has_product"]) {
        entities.add(new ProductOfCategory.fromMap(entity));
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

class ProductOfCategory extends Product {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get uid => this['uid'];
  set uid(String value) => this['uid'] = value;

  String get productName => this['productName'];
  set productName(String value) => this['productName'] = value;

  String get productIri => this['productIri'];
  set productIri(String value) => this['productIri'] = value;

  String get previewImageLink => this['previewImageLink'];
  set previewImageLink(String value) => this['previewImageLink'] = value;

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
      String productIri,
      String previewImageLink,
      List<Price> hasPrice,
      List<Company> belongsToCompany,
      List<Category> belongsToCategory,
      bool productIsActive}) {
    this["uid"] = uid;
    this["productName"] = productName;
    this["productIri"] = productIri;
    this["previewImageLink"] = previewImageLink;
    this["productIsActive"] = productIsActive;
    this
      ..belongsToCategory = belongsToCategory
      ..belongsToCompany = belongsToCompany;
  }

  ProductOfCategory.fromMap(Map map) {
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
