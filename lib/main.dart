import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/ui/bookmark_page.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:restaurant_app/utils/background_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  await AndroidAlarmManager.initialize();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

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
        create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
    ChangeNotifierProvider<SchedulingProvider>(
        create: (_) => SchedulingProvider()),
  ], child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

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
            BookmarksPage.routeName: (context) => const BookmarksPage(),
          },
        );
      },
    );
  }
}
