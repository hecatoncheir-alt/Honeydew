library company_enntity;

import 'dart:collection';

import 'category.dart';

class Company extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get uid => this['uid'];
  set uid(String value) => this['uid'] = value;

  String get companyName => this['companyName'];
  set companyName(String value) => this['companyName'] = value;

  String get companyIri => this['companyIri'];
  set companyIri(String value) => this['companyIri'] = value;

  bool get companyIsActive => this._entityMap['companyIsActive'];
  set companyIsActive(bool value) => this['companyIsActive'] = value;

  List<Category> get hasCategory => this['has_category'];
  set hasCategory(List<Category> value) => this['has_category'] = value;

  Company(
      {String uid,
      String companyName,
      String companyIri,
      List<Category> hasCategory,
      bool companyIsActive}) {
    this["uid"] = uid;
    this["companyName"] = companyName;
    this["companyIri"] = companyIri;
    this["companyIsActive"] = companyIsActive;
    this.hasCategory = hasCategory;
  }

  Company.fromMap(Map map) {
    this._entityMap = map;

    List<Category> categories = new List<Category>();
    if (map["has_category"] != null) {
      for (Map category in map["has_category"]) {
        categories.add(new Category.fromMap(category));
      }

      this._entityMap["has_category"] = categories;
    }
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}
