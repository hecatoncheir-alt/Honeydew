library cell_entity;

import 'dart:collection';

import 'category.dart';
import 'city.dart';
import 'price.dart';

class Cell extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get uid => this['uid'];
  set uid(String value) => this['uid'] = value;

  String get value => this['value'];
  set value(String value) => this['value'] = value;

  String get field => this['field'];
  set field(String value) => this['field'] = value;

  String get rowId => this['rowId'];
  set rowId(String value) => this['rowId'] = value;

  String get columnId => this['columnId'];
  set columnId(String value) => this['columnId'] = value;

  CellDetails get details => this['details'];
  set details(CellDetails value) => this['details'] = value;

  Cell(
      {String uid,
      String value,
      String field,
      String rowId,
      String columnId,
      CellDetails details}) {
    this
      ..uid = uid
      ..value = value
      ..field = field
      ..columnId = columnId
      ..rowId = rowId
      ..details = details;
  }

  Cell.fromMap(Map map) {
    this._entityMap = map;
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}

class CellDetails {
  Category category;
  City city;
  Price price;

  CellDetails({this.category, this.city, this.price});
}
