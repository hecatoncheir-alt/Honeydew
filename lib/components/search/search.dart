library search;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:honeydew/services.dart' show SocketService, EventData;
import 'package:honeydew/services/routes/paths.dart' as paths;

@Component(
    selector: 'search', templateUrl: 'search.html', styleUrls: ["search.css"])
class SearchComponent implements OnActivate, OnInit {
  SocketService socket;

  ProductsForPageSearchParams productsForPageSearchParams;
  ProductsForPageSearchResponse productsForPageSearchResponse =
      new ProductsForPageSearchResponse();

  Router router;

  Element el;
  InputElement searchField;

  SearchComponent(this.socket, this.router, this.el)
      : productsForPageSearchParams = new ProductsForPageSearchParams()
          ..CountProductsOnPage = 10
          ..Language = "ru",
        productsForPageSearchResponse = new ProductsForPageSearchResponse() {
    socket.data.listen((EventData event) async {
      switch (event.message) {
        case "Items by name not found":
          this.productsForPageSearchResponse =
              new ProductsForPageSearchResponse.fromMap(
                  json.decode(event.data));
          searchField.focus();
          break;

        case "Items by name ready":
          this.productsForPageSearchResponse =
              new ProductsForPageSearchResponse.fromMap(
                  json.decode(event.data));
          searchField.focus();
          break;
      }
    });
  }

  @override
  ngOnInit() {
    this.searchField = el.querySelector("#search__field");
  }

  @override
  void onActivate(_, RouterState newRouterState) async {
    productsForPageSearchParams.SearchedName =
        newRouterState.parameters["text"];

    if (newRouterState.parameters["page"] != null)
      productsForPageSearchParams.CurrentPage =
          int.parse(newRouterState.parameters["page"]);

    if (productsForPageSearchParams.CurrentPage == null &&
        productsForPageSearchParams.SearchedName != null)
      this.router.navigate(paths.search.toUrl(parameters: {
            "text": productsForPageSearchParams.SearchedName,
            "page": "1"
          }));

    if (productsForPageSearchParams.CurrentPage != null &&
        productsForPageSearchParams.SearchedName != null)
      this.searchProducts(this.productsForPageSearchParams);
  }

  Future<void> searchProducts(ProductsForPageSearchParams params) async {
    String encodedParams = json.encode(params);
    EventData message = new EventData("Need items by name", encodedParams);
    socket.write(message);
  }

  void search(ProductsForPageSearchParams params) {
    if (params.CurrentPage == null) {
      this.router.navigate(paths.searchWithPageParams
          .toUrl(parameters: {"text": params.SearchedName, "page": "1"}));
    } else {
      this.router.navigate(paths.searchWithPageParams.toUrl(parameters: {
            "text": params.SearchedName,
            "page": params.CurrentPage.toString()
          }));
    }
  }
}

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
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}

class ProductsForPageSearchParams extends MapBase {
  Map<String, dynamic> _entityMap = new Map<String, dynamic>();

  String get Language => this['Language'];
  set Language(String value) => this['Language'] = value;

  String get SearchedName => this['SearchedName'];
  set SearchedName(String value) => this['SearchedName'] = value;

  int get CurrentPage => this['CurrentPage'];
  set CurrentPage(int value) => this['CurrentPage'] = value;

  int get CountProductsOnPage => this['CountProductsOnPage'];
  set CountProductsOnPage(int value) => this['CountProductsOnPage'] = value;

  ProductsForPageSearchParams(
      {String SearchedName, int CurrentPage, int CountProductsOnPage}) {
    this["SearchedName"] = SearchedName;
    this["CurrentPage"] = CurrentPage;
    this["CountProductsOnPage"] = CountProductsOnPage;
  }

  operator [](Object key) => _entityMap[key];

  operator []=(dynamic key, dynamic value) => _entityMap[key] = value;

  get keys => _entityMap.keys;

  remove(key) => _entityMap.remove(key);

  clear() => _entityMap.clear();
}

class ProductsForPageSearchResponse extends ProductsForPageSearchParams {
  Map<String, dynamic> get entityMap => super._entityMap;
  set entityMap(Map<String, dynamic> map) => super._entityMap = map;

  ProductsForPageSearchResponse(
      {String SearchedName,
      int CurrentPage,
      int CountProductsOnPage,
      int TotalProductsFound,
      int TotalProductsOnOnePage}) {
    super.SearchedName = SearchedName;
    super.CurrentPage = CurrentPage;
    super.CountProductsOnPage = CountProductsOnPage;

    this
      ..TotalProductsFound = TotalProductsFound
      ..TotalProductsOnOnePage = TotalProductsOnOnePage;
  }

  ProductsForPageSearchResponse.fromMap(Map<String, dynamic> map) {
    entityMap = map;
    List<Product> products = new List<Product>();
    for (Map prod in map["Products"]) {
      products.add(new Product.fromMap(prod));
    }

    entityMap["Products"] = products;
  }

  int get TotalProductsOnOnePage => this['TotalProductsOnOnePage'];
  set TotalProductsOnOnePage(int value) =>
      this['TotalProductsOnOnePage'] = value;

  int get TotalProductsFound => this['TotalProductsFound'];
  set TotalProductsFound(int value) => this['TotalProductsFound'] = value;

  String get SearchedName => this['SearchedName'];
  set SearchedName(String value) => this['SearchedName'] = value;

  List<Product> get Products => this['Products'];
  set Products(List<Product> value) => this['Products'] = value;
}
