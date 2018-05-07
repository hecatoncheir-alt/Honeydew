library row_entity;

import 'dart:collection';
import 'cell.dart';

class Row extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get uid => this['uid'];
  set uid(String value) => this['uid'] = value;

  Map<String, Cell> get cells => this['cells'];
  set cells(Map<String,Cell> value) => this['cells'] = value;

  Row({String uid,Map<String, Cell> cells}) {
    this
      ..uid = uid
      ..cells = cells;
  }

  Row.fromMap(Map map) {
    this._entityMap = map;
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}
