import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: FutureBuilder<String>(
        future:
            DefaultAssetBundle.of(context).loadString('assets/restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Text('no data');
            } else {
              final Restaurants data =
                  Restaurants.fromJson(jsonDecode(snapshot.data.toString()));

              return ListView.builder(
                  itemCount: data.restaurants?.length,
                  itemBuilder: ((context, index) {
                    return _buildRestaurantItem(
                        context, data.restaurants?[index] as Restaurant);
                  }));
            }
          } else {
            return const SafeArea(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    leading: Image.network(
      restaurant.pictureId.toString(),
      width: 100,
      height: 100,
      fit: BoxFit.fill,
    ),
    trailing: const Icon(Icons.navigate_next),
    isThreeLine: true,
    title: Text(restaurant.name.toString(),
        style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Column(
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, size: 16.0),
            const SizedBox(width: 4.0),
            Text(restaurant.city.toString())
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.star,
              size: 16.0,
            ),
            const SizedBox(width: 4.0),
            Text(restaurant.rating.toString())
          ],
        )
      ],
    ),
  );
}
