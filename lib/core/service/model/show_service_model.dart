class ShowServiceModel {
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
  late final List<ImagesList> images;
  late final List<Null> rates;

  ShowServiceModel.fromJson(Map<String, dynamic> json) {
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
      images = <ImagesList>[];
      json['images'].forEach((v) {
        images.add(ImagesList.fromJson(v));
      });
    }
  }
}

class ImagesList {
  late final int id;
  late final String image;

  ImagesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
