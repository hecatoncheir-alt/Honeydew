library price_entity;

import 'dart:collection';
import 'company.dart';
import 'city.dart';

class Price extends MapBase {
  Map<String, dynamic> entity = new Map<String, dynamic>();

  String get uid => this['uid'];
  set uid(String value) => this['uid'] = value;

  int get priceValue => this['priceValue'];
  set priceValue(int value) => this['priceValue'] = value;

  String get priceFormatDateTime {
    DateTime dateTime = this['priceDateTime'];
    return "${dateTime.day}.${dateTime.month}.${dateTime.year}";
  }

  DateTime get priceDateTime => this['priceDateTime'];
  set priceDateTime(DateTime value) => this['priceDateTime'] = value;

  bool get priceIsActive => this['priceIsActive'];
  set priceIsActive(bool value) => this['priceIsActive'] = value;

  List<Company> get belongsToCompany => this['belongs_to_company'];
  set belongsToCompany(List<Company> value) =>
      this['belongs_to_company'] = value;

  List<City> get belongsToCity => this['belongs_to_city'];
  set belongsToCity(List<City> value) => this['belongs_to_city'] = value;

  Price.fromMap(Map map) {
    this.entity = map;

    // Предпоследний символ в дате перед Z можно отрезать
    String rfc3999Time = map["priceDateTime"];
    this.priceDateTime = DateTime.parse(rfc3999Time);

    List<Company> companies = new List<Company>();
    for (Map company in map["belongs_to_company"]) {
      companies.add(new Company.fromMap(company));
    }

    this.entity["belongs_to_company"] = companies;

    List<City> cities = new List<City>();
    if (map["belongs_to_city"] != null) {
      for (Map city in map["belongs_to_city"]) {
        cities.add(new City.fromMap(city));
      }
    }

    this.entity["belongs_to_city"] = cities;
  }

  operator [](Object key) => entity[key];

  operator []=(dynamic key, dynamic value) => entity[key] = value;

  get keys => entity.keys;

  remove(key) => entity.remove(key);

  clear() => entity.clear();
}
