import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  late final List<Restaurant> _restaurants = [];
  late Future<RestaurantResult> _restaurantResult;

  @override
  void initState() {
    _getRestaurantList();
    super.initState();
  }

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
                if (value.isEmpty == true) {
                  _getRestaurantList();
                } else {
                  _searchRestaurant(value);
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              key: UniqueKey(),
              shrinkWrap: true,
              itemCount: _restaurants.length,
              itemBuilder: ((context, index) {
                return CardRestaurant(restaurant: _restaurants[index]);
              }),
            ),
          ),
        ],
      ),
    );
  }

  void _searchRestaurant(String query) {
    var searchItems = _restaurants
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    _restaurants.clear();

    setState(() {
      _restaurants.addAll(searchItems);
    });
  }

  void _getRestaurantList() {
    _restaurantResult = ApiService().getRestaurantList();

    _restaurants.clear();
    _restaurantResult.then((value) {
      setState(() {
        _restaurants.addAll(value.restaurants);
      });
    });
  }
}
