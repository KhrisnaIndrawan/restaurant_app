import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  void initState() {
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
                if (value.isEmpty) {
                  Provider.of<RestaurantProvider>(context, listen: false)
                      .updateRestaurantList();
                } else {
                  Provider.of<RestaurantProvider>(context, listen: false)
                      .searchRestaurant(value);
                }
              },
            ),
          ),
          Expanded(
            child: Consumer<RestaurantProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.state == ResultState.hasData) {
                  return ListView.builder(
                    key: UniqueKey(),
                    shrinkWrap: true,
                    itemCount: state.result.restaurants.length,
                    itemBuilder: ((context, index) {
                      return CardRestaurant(
                          restaurant: state.result.restaurants[index]);
                    }),
                  );
                } else if (state.state == ResultState.noData) {
                  return Center(
                    child: Material(
                      child: Text(state.message),
                    ),
                  );
                } else if (state.state == ResultState.error) {
                  return Center(
                    child: Material(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return const Center(
                    child: Material(
                      child: Text(''),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
