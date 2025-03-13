class ChatMessagesModel {
  late final int id;
  late final String message;
  late final String type;
  late final String status;
  late final int orderId;
  late final int serviceId;
  late final int roomId;
  late final int toId;
  late final int fromId;
  late final String fromName;
  late final String fromPhone;
  late final String fromAvatar;
  late final String duration;
  late final String date;

  ChatMessagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    type = json['type'];
    status = json['status'];
    orderId = json['order_id'];
    serviceId = json['service_id'];
    roomId = json['room_id'];
    toId = json['to_id'];
    fromId = json['from_id'];
    fromName = json['from_name'];
    fromPhone = json['from_phone'];
    fromAvatar = json['from_avatar'];
    duration = json['duration'];
    date = json['date'];
  }
}
