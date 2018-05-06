library price_enntity;

import 'dart:collection';
import 'package:honeydew/entities.dart' show Company;

class Price extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get uid => this['uid'];
  set uid(String value) => this['uid'] = value;

  String get priceValue => this['priceValue'];
  set priceValue(String value) => this['priceValue'] = value;

  //TODO
//  String get priceDateTime => this['priceDateTime'];
//  set priceDateTime(String value) => this['priceDateTime'] = value;

  bool get priceIsActive => this['priceIsActive'];
  set priceIsActive(bool value) => this['priceIsActive'] = value;

  List<Company> get belongsToCompany => this['belongs_to_company'];
  set belongsToCompany(List<Company> value) =>
      this['belongs_to_company'] = value;

  //TODO
//  belongs_to_city

  Price.fromMap(Map map) {
    this._entityMap = map;

    List<Company> companies = new List<Company>();
    for (Map company in map["belongs_to_company"]) {
      companies.add(new Company.fromMap(company));
    }

    this._entityMap["belongs_to_company"] = companies;
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}
