library product_enntity;

import 'dart:collection';
import 'package:honeydew/entities.dart' show Price;

class Product extends MapBase {
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

  Product(
      {String uid,
      String productName,
      String productIri,
      String previewImageLink,
      bool productIsActive}) {
    this["uid"] = uid;
    this["productName"] = productName;
    this["productIri"] = productIri;
    this["previewImageLink"] = previewImageLink;
    this["productIsActive"] = productIsActive;
  }

  Product.fromMap(Map map) {
    this._entityMap = map;

    List<Price> prices = new List<Price>();
    for (Map price in map["has_price"]) {
      prices.add(new Price.fromMap(price));
    }

    _entityMap["has_price"] = prices;
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}
