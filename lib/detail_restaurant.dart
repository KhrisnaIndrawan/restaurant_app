import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              restaurant.pictureId.toString(),
              fit: BoxFit.fitWidth,
              width: double.infinity,
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    restaurant.name.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 28.0),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(restaurant.city.toString())
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'About the restaurant',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 8.0),
                  Text(restaurant.description.toString()),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Food Categories',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 8.0),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: restaurant.menus?.foods?.length,
                      itemBuilder: (context, index) {
                        var food = restaurant.menus?.foods?[index];

                        if (food != null) {
                          return _buildFooditem(context, food);
                        }
                      }),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Drink Categories',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 8.0),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: restaurant.menus?.drinks?.length,
                      itemBuilder: (context, index) {
                        var drink = restaurant.menus?.drinks?[index];

                        if (drink != null) {
                          return _buildDrinkitem(context, drink);
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFooditem(BuildContext context, Foods foods) {
  return ListTile(
    leading: const Icon(Icons.fastfood_rounded),
    title: Text(foods.name.toString()),
  );
}

Widget _buildDrinkitem(BuildContext context, Drinks drinks) {
  return ListTile(
    leading: const Icon(Icons.local_drink),
    title: Text(drinks.name.toString()),
  );
}
