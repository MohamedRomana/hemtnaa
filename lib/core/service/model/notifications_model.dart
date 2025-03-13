class NotificationsModel {
  late final int id;
  late final String message;
  late final String type;
  late final int orderId;
  late final String orderStatus;
  late final String date;
  late final String time;
  late final String duration;

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    type = json['type'];
    orderId = json['order_id'];
    orderStatus = json['order_status'];
    date = json['date'];
    time = json['time'];
    duration = json['duration'];
  }
}
