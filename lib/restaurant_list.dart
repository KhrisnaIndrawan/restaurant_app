import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restaurant_app/detail_restaurant.dart';
import 'package:restaurant_app/model/restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  List<Restaurant> restaurants = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  labelText: 'Search',
                  hintText: 'Restaurant Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.blue))),
              onChanged: (value) {
                _searchRestaurant(value);
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<String>(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/restaurant.json'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return const Text('no data');
                  } else {
                    final data = Restaurants.fromJson(
                        jsonDecode(snapshot.data.toString()));

                    restaurants
                        .addAll(data.restaurants as Iterable<Restaurant>);

                    return ListView.builder(
                        key: UniqueKey(),
                        shrinkWrap: true,
                        itemCount: restaurants.length,
                        itemBuilder: ((context, index) {
                          return _buildRestaurantItem(
                              context, restaurants[index]);
                        }));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _searchRestaurant(String query) {
    setState(() {
      restaurants.clear();
      var searchItems = restaurants
          .where((element) =>
              element.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      restaurants.addAll(searchItems);
    });
  }
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    leading: Hero(
      tag: restaurant.id.toString(),
      child: Image.network(
        restaurant.pictureId.toString(),
        width: 100,
        height: 100,
        fit: BoxFit.fill,
      ),
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
    onTap: () {
      Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant);
    },
  );
}
