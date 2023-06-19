import 'dart:convert';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantsResult {
  final bool error;
  final String message;
  final int count;
  List<Restaurant> restaurants;

  RestaurantsResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantsResult.fromRawJson(String str) =>
      RestaurantsResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
