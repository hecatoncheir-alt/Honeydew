class City {
  String uid;
  String name;
  bool isActive;

  City({this.uid, this.name, this.isActive});

  City.fromMap(Map<String, dynamic> map) {
    this
      ..uid = map["uid"]
      ..name = map["cityName"]
      ..isActive = map["cityIsActive"];
  }
}
