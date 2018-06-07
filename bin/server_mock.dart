library mock_socket;

import 'dart:io';
import 'dart:convert';

import 'package:honeydew/entities.dart' show EventData;

void main() {
  int port = 81;

  HttpServer.bind(InternetAddress.loopbackIPv4, port).then((HttpServer server) {
    print("Server is running on "
        "'http://${server.address.address}:$port/'");

    server.transform(new WebSocketTransformer()).listen((WebSocket socket) {
      socket
          .map((data) => new EventData.from(json.decode(data)))
          .listen((EventData eventData) {
//        {
//          Message:Need items by name,
//              Data:{
//        "SearchedName":"sum",
//        "CurrentPage":1,
//        "Tot
//        alProductsForOnePage":1,
//        "Language":"ru"
//        },
//        APIVersion:1.0   .0
//        }
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
                  "priceValue": 1,
                  "priceIsActive": true,
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
                  "priceValue": 2,
                  "priceIsActive": true,
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
                  "uid": "4",
                  "priceValue": 4,
                  "priceIsActive": true,
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
                  "priceValue": 5,
                  "priceIsActive": true,
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
