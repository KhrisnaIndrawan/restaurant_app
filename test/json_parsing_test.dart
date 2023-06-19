import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

void main() {
  const jsonString = '''
  {
    "error": false,
    "message": "success",
    "restaurant": {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [
            {
                "name": "Italia"
            },
            {
                "name": "Modern"
            }
        ],
        "menus": {
            "foods": [
                {
                    "name": "Paket rosemary"
                },
                {
                    "name": "Toastie salmon"
                }
            ],
            "drinks": [
                {
                    "name": "Es krim"
                },
                {
                    "name": "Sirup"
                }
            ]
        },
        "rating": 4.2,
        "customerReviews": [
            {
                "name": "Ahmad",
                "review": "Tidak rekomendasi untuk pelajar!",
                "date": "13 November 2019"
            }
        ]
    }
  }
  ''';

  test('JSON parsing test', () {
    final jsonData = jsonDecode(jsonString);

    expect(jsonData['error'], false);
    expect(jsonData['message'], 'success');

    final result = RestaurantResult.fromJson(jsonData);
    final restaurant = result.restaurant;

    expect(restaurant.id, 'rqdv5juczeskfw1e867');
    expect(restaurant.name, 'Melting Pot');
    expect(restaurant.description,
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...');
    expect(restaurant.city, 'Medan');
    expect(restaurant.address, 'Jln. Pandeglang no 19');
    expect(restaurant.pictureId, '14');
    expect(restaurant.categories?.length, 2);
    expect(restaurant.categories?[0].name, 'Italia');
    expect(restaurant.categories?[1].name, 'Modern');
    expect(restaurant.menus?.foods?.length, 2);
    expect(restaurant.menus!.foods?[0].name, 'Paket rosemary');
    expect(restaurant.menus!.foods?[1].name, 'Toastie salmon');
    expect(restaurant.menus?.drinks?.length, 2);
    expect(restaurant.menus!.drinks?[0].name, 'Es krim');
    expect(restaurant.menus!.drinks?[1].name, 'Sirup');
    expect(restaurant.rating, 4.2);
    expect(restaurant.customerReviews?.length, 1);
    expect(restaurant.customerReviews?[0].name, 'Ahmad');
    expect(restaurant.customerReviews?[0].review,
        'Tidak rekomendasi untuk pelajar!');
    expect(restaurant.customerReviews?[0].date, '13 November 2019');
  });
}
