library test_price;

import 'package:test/test.dart';
import 'package:honeydew/entities/price.dart';

void main() {
  test("Price can decode datetime", () async {
    // TODO: предпоследний символ в дате перед Z можно отрезать
    String rfc3999Time = "2018-05-16T14:08:11.7295653Z";
    rfc3999Time = rfc3999Time.replaceRange(
        rfc3999Time.length - 2, rfc3999Time.length - 1, "");

    DateTime time = DateTime.parse(rfc3999Time);

    Map mockPrice = <String, dynamic>{
      "uid": "2",
      "priceValue": 2,
      "priceIsActive": true,
      // "priceDateTime": "2018-02-10T08:34:35.6055814Z",
      // "priceDateTime": "2018-06-15 04:50:34 +0000 UTC",
      // "priceDateTime": "2009-10-10T23:00:00Z",
      "priceDateTime": "2018-06-16T14:08:11.7295653Z",
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
    };

    Price price = new Price.fromMap(mockPrice);

    DateTime dateTime = DateTime.parse(rfc3999Time);
    expect(price.priceDateTime.isAfter(dateTime), true);
  });
}
