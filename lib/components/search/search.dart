library search;

import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:honeydew/components.dart'
    show SearchResultComponent, PreloaderComponent;

import 'package:honeydew/services.dart' show SocketService, EventData;
import 'package:honeydew/services/routes/paths.dart' as paths;

import 'package:honeydew/entities.dart'
    show ProductsForPageSearchParams, ProductsForPageSearchResponse;

@Component(
    selector: 'search',
    templateUrl: 'search.html',
    styleUrls: const ["search.css"],
    directives: const [NgIf, SearchResultComponent, PreloaderComponent])
class SearchComponent implements OnActivate, OnInit, OnDestroy {
  Router router;

  SocketService socket;
  StreamSubscription<EventData> subscription;

  ProductsForPageSearchParams productsForPageSearchParams;
  ProductsForPageSearchResponse productsForPageSearchResponse;

  static int totalProductsForOnePageCount = 1;

  @ViewChild('searchField')
  InputElement searchField;

  SearchComponent(this.socket, this.router)
      : productsForPageSearchParams = new ProductsForPageSearchParams()
          ..TotalProductsForOnePage = totalProductsForOnePageCount
          ..Language = "ru",
        productsForPageSearchResponse = new ProductsForPageSearchResponse();

  Future<Null> subscribeOnEvents(Stream<EventData> stream) async {
    this.subscription = stream.listen((EventData event) {
      switch (event.message) {
        case "Items by name not found":
          this.productsForPageSearchResponse =
              new ProductsForPageSearchResponse.fromMap(
                  json.decode(event.data));
          this.searchInProgress = false;
          searchField.focus();
          break;

        case "Items by name ready":
          this.productsForPageSearchResponse =
              new ProductsForPageSearchResponse.fromMap(
                  json.decode(event.data));
          this.searchInProgress = false;
          searchField.focus();
          break;
      }
    });
  }

  @override
  void ngOnInit() => this.subscribeOnEvents(socket.data);

  @override
  void ngOnDestroy() => this.subscription.cancel();

  @override
  void onActivate(_, RouterState newRouterState) {
    productsForPageSearchParams.SearchedName =
        newRouterState.parameters["text"];

    if (newRouterState.parameters["page"] != null)
      productsForPageSearchParams.CurrentPage =
          int.parse(newRouterState.parameters["page"]);

    if (productsForPageSearchParams.CurrentPage == null &&
        productsForPageSearchParams.SearchedName != null)
      this.router.navigate(paths.searchWithPageParams.toUrl(parameters: {
            "text": productsForPageSearchParams.SearchedName,
            "page": "1"
          }));

    if (productsForPageSearchParams.CurrentPage != null &&
        productsForPageSearchParams.SearchedName != null)
      this.searchProducts(this.productsForPageSearchParams);

    searchField.focus();
  }

  bool searchInProgress = false;

  Future<void> searchProducts(ProductsForPageSearchParams params) async {
    String encodedParams = json.encode(params);
    EventData message = new EventData("Need items by name", encodedParams);
    this.searchInProgress = true;
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
