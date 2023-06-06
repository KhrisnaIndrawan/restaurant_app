import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Restaurant App'),
        // ),
        // body: FutureBuilder<String>(
        //   future:
        //       DefaultAssetBundle.of(context).loadString('assets/restaurant.json'),
        //   builder: (context, snapshot) {
        //     final Restaurants restaurant = Restaurants.fromJson(snapshot.data);
        //   },
        // ),
        );
  }
}
