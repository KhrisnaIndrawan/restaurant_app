import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/bookmark_page.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';
import 'package:awesome_snackbar_content_new/awesome_snackbar_content.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              Navigator.pushNamed(context, BookmarksPage.routeName);
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                child: Consumer<PreferencesProvider>(
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dark Mode'),
                        Switch.adaptive(
                          value: Provider.of<PreferencesProvider>(context,
                                  listen: false)
                              .isDarkTheme,
                          onChanged: (value) {
                            Provider.of<PreferencesProvider>(context,
                                    listen: false)
                                .enableDarkTheme(value);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              PopupMenuItem(
                child: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Daily Suggestion'),
                      Switch.adaptive(
                        value: scheduled.isScheduled,
                        onChanged: (value) async {
                          scheduled.scheduledNews(value);
                        },
                      ),
                    ],
                  );
                }),
              )
            ],
          )
        ],
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
                  return const Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ));
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
                  return MaterialBanner(
                      elevation: 0,
                      forceActionsBelow: true,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'On Snap!',
                        message: 'No Restaurant Data!',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                      ),
                      actions: const [SizedBox.shrink()]);
                } else if (state.state == ResultState.error) {
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
        ],
      ),
    );
  }
}
