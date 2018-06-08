library price_entity;

import 'dart:collection';
import 'company.dart';
import 'city.dart';

class Price extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get uid => this['uid'];
  set uid(String value) => this['uid'] = value;

  int get priceValue => this['priceValue'];
  set priceValue(int value) => this['priceValue'] = value;

  //TODO
//  String get priceDateTime => this['priceDateTime'];
//  set priceDateTime(String value) => this['priceDateTime'] = value;

  bool get priceIsActive => this['priceIsActive'];
  set priceIsActive(bool value) => this['priceIsActive'] = value;

  List<Company> get belongsToCompany => this['belongs_to_company'];
  set belongsToCompany(List<Company> value) =>
      this['belongs_to_company'] = value;

  List<City> get belongsToCity => this['belongs_to_city'];
  set belongsToCity(List<City> value) => this['belongs_to_city'] = value;

  Price.fromMap(Map map) {
    this._entityMap = map;

    List<Company> companies = new List<Company>();
    for (Map company in map["belongs_to_company"]) {
      companies.add(new Company.fromMap(company));
    }

    this._entityMap["belongs_to_company"] = companies;

    List<City> cities = new List<City>();
    if (map["belongs_to_city"] != null) {
      for (Map city in map["belongs_to_city"]) {
        cities.add(new City.fromMap(city));
      }
    }

    this._entityMap["belongs_to_city"] = cities;
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}
