class ShowCartModel {
  late final int id;
  late final int count;
  late final int delivery;
  late final int total;
  late final int totalWithValue;
  late final int valueAdded;
  late final int salerId;
  late final String salerName;
  late final String salerPhone;
  late final String salerFullPhone;
  late final String salerAvatar;
  late final int salerRate;
  late final int salerRateCount;
  late final String notes;
  late final List<CartItems> cartItems;

  ShowCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    delivery = json['delivery'];
    total = json['total'];
    totalWithValue = json['total_with_value'];
    valueAdded = json['value_added'];
    salerId = json['saler_id'];
    salerName = json['saler_name'];
    salerPhone = json['saler_phone'];
    salerFullPhone = json['saler_full_phone'];
    salerAvatar = json['saler_avatar'];
    salerRate = json['saler_rate'];
    salerRateCount = json['saler_rate_count'];
    notes = json['notes'];
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems.add(CartItems.fromJson(v));
      });
    }
  }
}

class CartItems {
  late final int id;
  late final int count;
  late final int total;
  late final int totalWithValue;
  late final int valueAdded;
  late final bool hasCertificate;
  late final String notes;
  late final int salerId;
  late final String salerName;
  late final String salerPhone;
  late final String salerFullPhone;
  late final String salerAvatar;
  late final int salerRate;
  late final int salerRateCount;
  late final String serviceTitle;
  late final String serviceDesc;
  late final int servicePrice;
  late final int servicePriceWithValue;
  late final int serviceValueAdded;
  late final bool serviceIsFav;
  late final int serviceSectionId;
  late final String serviceSectionTitle;
  late final String serviceFirstImage;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    total = json['total'];
    totalWithValue = json['total_with_value'];
    valueAdded = json['value_added'];
    hasCertificate = json['has_certificate'];
    notes = json['notes'];
    salerId = json['saler_id'];
    salerName = json['saler_name'];
    salerPhone = json['saler_phone'];
    salerFullPhone = json['saler_full_phone'];
    salerAvatar = json['saler_avatar'];
    salerRate = json['saler_rate'];
    salerRateCount = json['saler_rate_count'];
    serviceTitle = json['service_title'];
    serviceDesc = json['service_desc'];
    servicePrice = json['service_price'];
    servicePriceWithValue = json['service_price_with_value'];
    serviceValueAdded = json['service_value_added'];
    serviceIsFav = json['service_is_fav'];
    serviceSectionId = json['service_section_id'];
    serviceSectionTitle = json['service_section_title'];
    serviceFirstImage = json['service_first_image'];
  }
}
