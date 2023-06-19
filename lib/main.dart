import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/data/db/database_helper.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (_) => RestaurantProvider(apiService: ApiService())),
    ChangeNotifierProvider(
      create: (_) => PreferencesProvider(
        preferencesHelper: PreferencesHelper(
          sharedPreferences: SharedPreferences.getInstance(),
        ),
      ),
    ),
    ChangeNotifierProvider(
        create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()))
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          title: 'Restaurant App',
          theme: provider.themeData,
          initialRoute: RestaurantListPage.routeName,
          routes: {
            RestaurantListPage.routeName: (context) =>
                const RestaurantListPage(),
            RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                  id: ModalRoute.of(context)?.settings.arguments as String,
                ),
          },
        );
      },
    );
  }
}
