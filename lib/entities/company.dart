library company_enntity;

import 'dart:collection';

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

  Company(
      {String uid,
      String companyName,
      String companyIri,
      bool companyIsActive}) {
    this["uid"] = uid;
    this["companyName"] = companyName;
    this["companyIri"] = companyIri;
    this["companyIsActive"] = companyIsActive;
  }

  Company.fromMap(Map map) {
    this._entityMap = map;
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}
