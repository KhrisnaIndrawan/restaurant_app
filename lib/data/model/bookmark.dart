class Bookmark {
  String id;
  String name;
  String city;
  String pictureId;
  double rating;

  Bookmark(
      {required this.id,
      required this.name,
      required this.city,
      required this.pictureId,
      required this.rating});

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        pictureId: json["pictureId"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "pictureId": pictureId,
        "rating": rating,
      };
}
