import 'dart:collection';

class EventData extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get message => this['Message'];

  set message(String value) => this['Message'] = value;

  String get data => this['Data'];

  set data(String value) => this['Data'] = value;

  String get APIVersion => this['APIVersion'];

  set APIVersion(String value) => this['APIVersion'] = value;

  EventData(String message, [String data, String apiVersion]) {
    this["Message"] = message;
    this["Data"] = data;
    this["APIVersion"] = apiVersion;
  }

  EventData.from(Map<String,dynamic> entity) {
    this._entityMap = entity;
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}
