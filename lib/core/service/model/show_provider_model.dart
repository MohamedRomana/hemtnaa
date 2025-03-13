class ShowProviderModel {
  late final int id;
  late final String firstName;
  late final String email;
  late final String phone;
  late final String fullPhone;
  late final int delivery;
  late final double lat;
  late final double lng;
  late final int distance;
  late final bool isUserFav;
  late final int rate;
  late final int rateCount;
  late final int finishOrdersCount;
  late final int currentOrdersCount;
  late final int servicesCount;
  late final String avatar;
  late final List<Rates> rates;
  late final List<SubSections> subSections;
  late final List<AllServiceModel> services;

  ShowProviderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    email = json['email'];
    phone = json['phone'];
    fullPhone = json['full_phone'];
    delivery = json['delivery'];
    lat = json['lat'];
    lng = json['lng'];
    distance = json['distance'];
    isUserFav = json['is_user_fav'];
    rate = json['rate'];
    rateCount = json['rate_count'];
    finishOrdersCount = json['finish_orders_count'];
    currentOrdersCount = json['current_orders_count'];
    servicesCount = json['services_count'];
    avatar = json['avatar'];
    if (json['rates'] != null) {
      rates = <Rates>[];
      json['rates'].forEach((v) {
        rates.add(Rates.fromJson(v));
      });
    }
    if (json['sub_sections'] != null) {
      subSections = <SubSections>[];
      json['sub_sections'].forEach((v) {
        subSections.add(SubSections.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <AllServiceModel>[];
      json['services'].forEach((v) {
        services.add(AllServiceModel.fromJson(v));
      });
    }
  }
}

class Rates {
  late final int userId;
  late final String userName;
  late final String userAvatar;
  late final String rate;
  late final String desc;

  Rates.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userAvatar = json['user_avatar'];
    rate = json['rate'];
    desc = json['desc'];
  }
}

class SubSections {
  late final int id;
  late final String title;
  late final bool checked;

  SubSections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    checked = json['checked'];
  }
}

class AllServiceModel {
  late final int id;
  late final String title;
  late final String desc;
  late final int price;
  late final int priceWithValue;
  late final int valueAdded;
  late final bool isFav;
  late final int salerId;
  late final String salerName;
  late final String salerPhone;
  late final String salerFullPhone;
  late final String salerAvatar;
  late final int salerRate;
  late final int salerRateCount;
  late final int sectionId;
  late final String sectionTitle;
  late final String firstImage;
  late final List<Images> images;
  late final List<Null> rates;

  AllServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    price = json['price'];
    priceWithValue = json['price_with_value'];
    valueAdded = json['value_added'];
    isFav = json['is_fav'];
    salerId = json['saler_id'];
    salerName = json['saler_name'];
    salerPhone = json['saler_phone'];
    salerFullPhone = json['saler_full_phone'];
    salerAvatar = json['saler_avatar'];
    salerRate = json['saler_rate'];
    salerRateCount = json['saler_rate_count'];
    sectionId = json['section_id'];
    sectionTitle = json['section_title'];
    firstImage = json['first_image'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
  }
}

class Images {
  late final int id;
  late final String image;

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}
