library column_entity;

import 'dart:collection';

import 'package:honeydew/entities.dart' show Company;

class Column extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get uid => this['uid'];
  set uid(String value) => this['uid'] = value;

  String get title => this['title'];
  set title(String value) => this['title'] = value;

  String get field => this['field'];
  set field(String value) => this['field'] = value;

  Company get company => this['company'];
  set company(Company value) => this['company'] = value;

  Column({String uid, String title, String field, Company company}) {
    this
      ..uid = uid
      ..title = title
      ..field = field
      ..company = company;
  }

  Column.fromMap(Map map) {
    this._entityMap = map;
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}
