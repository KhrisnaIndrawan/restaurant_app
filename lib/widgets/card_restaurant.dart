import 'package:restaurant_app/data/model/bookmark.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
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
              trailing: isBookmarked
                  ? IconButton(
                      icon: const Icon(Icons.bookmark),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () => provider.removeBookmark(restaurant.id),
                    )
                  : IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () => provider.addBookmark(Bookmark(
                          id: restaurant.id,
                          name: restaurant.name,
                          city: restaurant.city,
                          pictureId: restaurant.pictureId,
                          rating: restaurant.rating)),
                    ),
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
                    arguments: restaurant.id);
              },
            );
          },
        );
      },
    );
  }
}
