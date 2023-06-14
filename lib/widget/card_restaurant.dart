import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:flutter/material.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: restaurant.id,
        child: Image.network(
          'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
          width: 100,
          height: 100,
          fit: BoxFit.fill,
        ),
      ),
      trailing: const Icon(Icons.navigate_next),
      isThreeLine: true,
      title: Text(restaurant.name,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, size: 16.0),
              const SizedBox(width: 4.0),
              Text(restaurant.city)
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
}
