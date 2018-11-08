library row_entity;

import 'dart:collection';
import 'cell.dart';
import 'package:honeydew/entities.dart' show Product;

class Row extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get uid => this['uid'];
  set uid(String value) => this['uid'] = value;

  Map<String, Cell> get cells => this['cells'];
  set cells(Map<String, Cell> value) => this['cells'] = value;

  Product get product => this['product'];
  set product(Product value) => this['product'] = value;

  Row({String uid, Map<String, Cell> cells, Product product}) {
    this
      ..uid = uid
      ..cells = cells
      ..product = product;
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
