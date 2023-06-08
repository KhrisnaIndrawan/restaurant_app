class Restaurants {
  List<Restaurant>? _restaurants;

  Restaurants({List<Restaurant>? restaurants}) {
    if (restaurants != null) {
      _restaurants = restaurants;
    }
  }

  List<Restaurant>? restaurants() => _restaurants;

  Restaurants.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      _restaurants = <Restaurant>[];
      json['restaurants'].forEach((v) {
        _restaurants!.add(Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_restaurants != null) {
      data['restaurants'] = _restaurants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurant {
  String? _id;
  String? _name;
  String? _description;
  String? _pictureId;
  String? _city;
  double? _rating;
  Menus? _menus;

  Restaurant(
      {String? id,
      String? name,
      String? description,
      String? pictureId,
      String? city,
      double? rating,
      Menus? menus}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (description != null) {
      _description = description;
    }
    if (pictureId != null) {
      _pictureId = pictureId;
    }
    if (city != null) {
      _city = city;
    }
    if (rating != null) {
      _rating = rating;
    }
    if (menus != null) {
      _menus = menus;
    }
  }

  String? id() => _id;
  String? name() => _name;
  String? description() => _description;
  String? pictureId() => _pictureId;
  String? city() => _city;
  double? rating() => _rating;
  Menus? menus() => _menus;

  Restaurant.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _pictureId = json['pictureId'];
    _city = json['city'];
    _rating = json['rating'];
    _menus = json['menus'] != null ? Menus.fromJson(json['menus']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['description'] = _description;
    data['pictureId'] = _pictureId;
    data['city'] = _city;
    data['rating'] = _rating;
    if (_menus != null) {
      data['menus'] = _menus!.toJson();
    }
    return data;
  }
}

class Menus {
  List<Foods>? _foods;
  List<Drinks>? _drinks;

  Menus({List<Foods>? foods, List<Drinks>? drinks}) {
    if (foods != null) {
      _foods = foods;
    }
    if (drinks != null) {
      _drinks = drinks;
    }
  }

  List<Foods>? foods() => _foods;
  List<Drinks>? drinks() => _drinks;

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      _foods = <Foods>[];
      json['foods'].forEach((v) {
        _foods!.add(Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      _drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        _drinks!.add(Drinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_foods != null) {
      data['foods'] = _foods!.map((v) => v.toJson()).toList();
    }
    if (_drinks != null) {
      data['drinks'] = _drinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Drinks {
  String? _name;

  Drinks({String? name}) {
    if (name != null) {
      _name = name;
    }
  }

  String? name() => _name;

  Drinks.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    return data;
  }
}

class Foods {
  String? _name;

  Foods({String? name}) {
    if (name != null) {
      _name = name;
    }
  }

  String? name() => _name;

  Foods.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    return data;
  }
}
