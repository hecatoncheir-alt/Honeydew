library row_entity;

import 'dart:collection';

class Row extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  Row.fromMap(Map map) {
    this._entityMap = map;
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}
