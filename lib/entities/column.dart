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

  ColumnDetails get details => this['details'];
  set details(ColumnDetails value) => this['details'] = value;

  Column({String uid, String title, String field, ColumnDetails details}) {
    this
      ..uid = uid
      ..title = title
      ..field = field
      ..details = details;
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

class ColumnDetails {
  Company company;

  ColumnDetails({this.company});
}
