class Restaurants {
  List<Restaurant>? _restaurants;

  Restaurants({List<Restaurant>? restaurants}) {
    if (restaurants != null) {
      this._restaurants = restaurants;
    }
  }

  List<Restaurant>? get restaurants => _restaurants;
  set restaurants(List<Restaurant>? restaurants) => _restaurants = restaurants;

  Restaurants.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      _restaurants = <Restaurant>[];
      json['restaurants'].forEach((v) {
        _restaurants!.add(new Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._restaurants != null) {
      data['restaurants'] = this._restaurants!.map((v) => v.toJson()).toList();
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
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (description != null) {
      this._description = description;
    }
    if (pictureId != null) {
      this._pictureId = pictureId;
    }
    if (city != null) {
      this._city = city;
    }
    if (rating != null) {
      this._rating = rating;
    }
    if (menus != null) {
      this._menus = menus;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get pictureId => _pictureId;
  set pictureId(String? pictureId) => _pictureId = pictureId;
  String? get city => _city;
  set city(String? city) => _city = city;
  double? get rating => _rating;
  set rating(double? rating) => _rating = rating;
  Menus? get menus => _menus;
  set menus(Menus? menus) => _menus = menus;

  Restaurant.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _pictureId = json['pictureId'];
    _city = json['city'];
    _rating = json['rating'];
    _menus = json['menus'] != null ? new Menus.fromJson(json['menus']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['description'] = this._description;
    data['pictureId'] = this._pictureId;
    data['city'] = this._city;
    data['rating'] = this._rating;
    if (this._menus != null) {
      data['menus'] = this._menus!.toJson();
    }
    return data;
  }
}

class Menus {
  List<Foods>? _foods;
  List<Drinks>? _drinks;

  Menus({List<Foods>? foods, List<Drinks>? drinks}) {
    if (foods != null) {
      this._foods = foods;
    }
    if (drinks != null) {
      this._drinks = drinks;
    }
  }

  List<Foods>? get foods => _foods;
  set foods(List<Foods>? foods) => _foods = foods;
  List<Drinks>? get drinks => _drinks;
  set drinks(List<Drinks>? drinks) => _drinks = drinks;

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      _foods = <Foods>[];
      json['foods'].forEach((v) {
        _foods!.add(new Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      _drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        _drinks!.add(new Drinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._foods != null) {
      data['foods'] = this._foods!.map((v) => v.toJson()).toList();
    }
    if (this._drinks != null) {
      data['drinks'] = this._drinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Drinks {
  String? _name;

  Drinks({String? name}) {
    if (name != null) {
      this._name = name;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;

  Drinks.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    return data;
  }
}

class Foods {
  String? _name;

  Foods({String? name}) {
    if (name != null) {
      this._name = name;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;

  Foods.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    return data;
  }
}
