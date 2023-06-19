import 'dart:convert';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantResult {
  final bool error;
  final String message;
  final Restaurant restaurant;

  RestaurantResult({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantResult.fromRawJson(String str) =>
      RestaurantResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      RestaurantResult(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}
