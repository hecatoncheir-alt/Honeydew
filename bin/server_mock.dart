library mock_socket;

import 'dart:io';
import 'dart:convert';

import 'package:honeydew/entities.dart' show EventData;

void main() {
  int port = 8181;

  HttpServer.bind(InternetAddress.loopbackIPv4, port).then((HttpServer server) {
    print("Server is running on "
        "'http://${server.address.address}:$port/'");

    server.transform(new WebSocketTransformer()).listen((WebSocket socket) {
      socket
          .map((data) => new EventData.from(json.decode(data)))
          .listen((EventData eventData) {
        // Input message example
        // Map allProducts = {
        //   "Message": "Need items by name",
        //   "Data": json.encode({
        //     "SearchedName": "sum",
        //     "CurrentPage": 1,
        //     "TotalProductsForOnePage": 1,
        //     "Language": "ru"
        //   }),
        //   "APIVersion": "1.0.0"
        // };

        if (eventData.message == "Need items by name") {
          EventData event = new EventData("Items by name ready");
          List<Map> products = <Map>[
            <String, dynamic>{
              "uid": "1",
              "productName": "Test product",
              "productIri": "http://",
              "previewImageLink": "http://",
              "productIsActive": true,
              "belongs_to_category": <Map>[
                <String, dynamic>{
                  "uid": "1",
                  "categoryName": "Test category",
                  "categoryIsActive": true,
                  "belongs_to_company": <Map>[
                    <String, dynamic>{
                      "uid": "1",
                      "companyName": "Test company",
                      "companyIri": "http://",
                      "companyIsActive": true,
                    }
                  ],
                }
              ],
              "belongs_to_company": <Map>[
                <String, dynamic>{
                  "uid": "1",
                  "companyName": "Test company",
                  "companyIri": "http://",
                  "companyIsActive": true,
                }
              ],
              "has_price": <Map>[
                <String, dynamic>{
                  "uid": "1",
                  "priceValue": 10300,
                  "priceIsActive": true,
                  "priceDateTime": "2018-00-10T08:34:35.6055814Z",
                  "belongs_to_city": <Map>[
                    <String, dynamic>{
                      "uid": "1",
                      "cityName": "Test city",
                      "cityIsActive": true,
                    }
                  ],
                  "belongs_to_company": <Map>[
                    <String, dynamic>{
                      "uid": "1",
                      "companyName": "Test company",
                      "companyIri": "http://",
                      "companyIsActive": true,
                    }
                  ]
                },
                <String, dynamic>{
                  "uid": "2",
                  "priceValue": 20000,
                  "priceIsActive": true,
                  "priceDateTime": "2018-02-10T08:34:35.6055814Z",
                  "belongs_to_city": <Map>[
                    <String, dynamic>{
                      "uid": "1",
                      "cityName": "Test city",
                      "cityIsActive": true,
                    }
                  ],
                  "belongs_to_company": <Map>[
                    <String, dynamic>{
                      "uid": "1",
                      "companyName": "Test company",
                      "companyIri": "http://",
                      "companyIsActive": true,
                    }
                  ]
                }
              ]
            },
            <String, dynamic>{
              "uid": "2",
              "productName": "Second test product",
              "productIri": "http://",
              "previewImageLink": "http://",
              "productIsActive": true,
              "belongs_to_category": <Map>[
                <String, dynamic>{
                  "uid": "1",
                  "categoryName": "Test category",
                  "categoryIsActive": true,
                  "belongs_to_company": <Map>[
                    <String, dynamic>{
                      "uid": "1",
                      "companyName": "Test company",
                      "companyIri": "http://",
                      "companyIsActive": true,
                    }
                  ],
                }
              ],
              "belongs_to_company": <Map>[
                <String, dynamic>{
                  "uid": "1",
                  "companyName": "Test company",
                  "companyIri": "http://",
                  "companyIsActive": true,
                }
              ],
              "has_price": <Map>[
                <String, dynamic>{
                  "uid": "19",
                  "priceValue": 19000,
                  "priceIsActive": true,
                  "priceDateTime": "2018-05-10T08:34:35.6055814Z",
                  "belongs_to_city": <Map>[
                    <String, dynamic>{
                      "uid": "1",
                      "cityName": "Test city",
                      "cityIsActive": true,
                    }
                  ],
                  "belongs_to_company": <Map>[
                    <String, dynamic>{
                      "uid": "1",
                      "companyName": "Test company",
                      "companyIri": "http://",
                      "companyIsActive": true,
                    }
                  ]
                },
                <String, dynamic>{
                  "uid": "4",
                  "priceValue": 40000,
                  "priceIsActive": true,
                  "priceDateTime": "2018-03-10T08:34:35.6055814Z",
                  "belongs_to_city": <Map>[
                    <String, dynamic>{
                      "uid": "1",
                      "cityName": "Test city",
                      "cityIsActive": true,
                    }
                  ],
                  "belongs_to_company": <Map>[
                    <String, dynamic>{
                      "uid": "1",
                      "companyName": "Test company",
                      "companyIri": "http://",
                      "companyIsActive": true,
                    }
                  ]
                },
                <String, dynamic>{
                  "uid": "5",
                  "priceValue": 50000,
                  "priceIsActive": true,
                  "priceDateTime": "2018-01-10T08:34:35.6055814Z",
                  "belongs_to_city": <Map>[
                    <String, dynamic>{
                      "uid": "1",
                      "cityName": "Test city",
                      "cityIsActive": true,
                    }
                  ],
                  "belongs_to_company": <Map>[
                    <String, dynamic>{
                      "uid": "2",
                      "companyName": "Second test company",
                      "companyIri": "http://",
                      "companyIsActive": true,
                    }
                  ]
                }
              ]
            }
          ];

          Map data = json.decode(eventData.data);

          data["Products"] = products;
          data["TotalProductsFound"] = 1;

          event.APIVersion = eventData.APIVersion;
          event.data = json.encode(data);
          socket.add(json.encode(event));
        }
      });
    });
  });
}
