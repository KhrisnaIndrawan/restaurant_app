import 'package:restaurant_app/data/model/bookmark.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';

class CardBookmark extends StatelessWidget {
  final Bookmark bookmark;

  const CardBookmark({Key? key, required this.bookmark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListTile(
            leading: Hero(
              tag: bookmark.id,
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/small/${bookmark.pictureId}',
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            isThreeLine: true,
            title: Text(bookmark.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16.0),
                    const SizedBox(width: 4.0),
                    Text(bookmark.city)
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16.0,
                    ),
                    const SizedBox(width: 4.0),
                    Text(bookmark.rating.toString())
                  ],
                )
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                  arguments: bookmark.id);
            },
          );
        } else {
          return Center(
            child: Material(
              child: Text(provider.message),
            ),
          );
        }
      },
    );
  }
}
