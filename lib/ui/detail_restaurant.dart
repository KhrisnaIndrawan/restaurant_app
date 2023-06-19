import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/bookmark.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_details_provider.dart';
import '../data/model/restaurant.dart';
import 'package:awesome_snackbar_content_new/awesome_snackbar_content.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  const RestaurantDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantProvider(apiService: ApiService(), id: id),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Restaurant App'),
          ),
          body: SingleChildScrollView(
            child: Consumer<RestaurantProvider>(
              builder: (context, restaurantProvider, _) {
                if (restaurantProvider.state == ResultState.loading) {
                  return const Center(
                      heightFactor: 12,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ));
                } else if (restaurantProvider.state == ResultState.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: restaurantProvider.result.restaurant.id,
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/${restaurantProvider.result.restaurant.pictureId}',
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16.0),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    restaurantProvider.result.restaurant.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28.0),
                                    textAlign: TextAlign.start,
                                  ),
                                  Consumer<DatabaseProvider>(
                                    builder: (context, provider, child) {
                                      return FutureBuilder<bool>(
                                        future: provider.isBookmarked(
                                            restaurantProvider
                                                .result.restaurant.id),
                                        builder: (context, snapshot) {
                                          var isBookmarked =
                                              snapshot.data ?? false;
                                          return isBookmarked
                                              ? IconButton(
                                                  icon: const Icon(
                                                      Icons.bookmark),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  onPressed: () => Provider.of<
                                                              DatabaseProvider>(
                                                          context,
                                                          listen: false)
                                                      .removeBookmark(
                                                          restaurantProvider
                                                              .result
                                                              .restaurant
                                                              .id),
                                                )
                                              : IconButton(
                                                  icon: const Icon(
                                                      Icons.bookmark_border),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  onPressed: () {
                                                    Provider
                                                            .of<
                                                                    DatabaseProvider>(context,
                                                                listen: false)
                                                        .addBookmark(Bookmark(
                                                            id:
                                                                restaurantProvider
                                                                    .result
                                                                    .restaurant
                                                                    .id,
                                                            name:
                                                                restaurantProvider
                                                                    .result
                                                                    .restaurant
                                                                    .name,
                                                            city:
                                                                restaurantProvider
                                                                    .result
                                                                    .restaurant
                                                                    .city,
                                                            pictureId:
                                                                restaurantProvider
                                                                    .result
                                                                    .restaurant
                                                                    .pictureId,
                                                            rating:
                                                                restaurantProvider
                                                                    .result
                                                                    .restaurant
                                                                    .rating));
                                                  },
                                                );
                                        },
                                      );
                                    },
                                  )
                                ]),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16.0,
                                ),
                                const SizedBox(width: 4.0),
                                Text(restaurantProvider.result.restaurant.city)
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16.0,
                                ),
                                const SizedBox(width: 4.0),
                                Text(restaurantProvider.result.restaurant.rating
                                    .toString())
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            const Text(
                              'About the restaurant',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 8.0),
                            Text(restaurantProvider
                                .result.restaurant.description),
                            const SizedBox(height: 16.0),
                            const Text(
                              'Food Categories',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 8.0),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: restaurantProvider
                                    .result.restaurant.menus?.foods?.length,
                                itemBuilder: (context, index) {
                                  var food = restaurantProvider
                                      .result.restaurant.menus!.foods?[index];

                                  return _buildFooditem(context, food);
                                }),
                            const SizedBox(height: 16.0),
                            const Text(
                              'Drink Categories',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 8.0),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: restaurantProvider
                                    .result.restaurant.menus?.drinks?.length,
                                itemBuilder: (context, index) {
                                  var drink = restaurantProvider
                                      .result.restaurant.menus!.drinks?[index];

                                  return _buildDrinkitem(context, drink);
                                }),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (restaurantProvider.state == ResultState.noData) {
                  return MaterialBanner(
                      elevation: 0,
                      forceActionsBelow: true,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'On Snap!',
                        message: 'No Restaurant Data',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                      ),
                      actions: const [SizedBox.shrink()]);
                } else if (restaurantProvider.state == ResultState.error) {
                  return MaterialBanner(
                      elevation: 0,
                      forceActionsBelow: true,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'On Snap!',
                        message:
                            'Cannot access host, please check your internet connection!',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                      ),
                      actions: const [SizedBox.shrink()]);
                } else {
                  return MaterialBanner(
                      elevation: 0,
                      forceActionsBelow: true,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'On Snap!',
                        message:
                            'Cannot access host, please check your internet connection!',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                      ),
                      actions: const [SizedBox.shrink()]);
                }
              },
            ),
          ),
        );
      },
    );
  }
}

Widget _buildFooditem(BuildContext context, Category? foods) {
  return ListTile(
    leading: const Icon(Icons.fastfood_rounded),
    title: Text(foods!.name.toString()),
  );
}

Widget _buildDrinkitem(BuildContext context, Category? drinks) {
  return ListTile(
    leading: const Icon(Icons.local_drink),
    title: Text(drinks!.name.toString()),
  );
}
