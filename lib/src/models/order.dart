// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.id,
    required this.idUser,
    required this.idDelivery,
    required this.idAddress,
    required this.lat,
    required this.lng,
    required this.status,
    required this.timestamp,
  });

  String id;
  String idUser;
  String idDelivery;
  String idAddress;
  double lat;
  double lng;
  String status;
  String timestamp;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        idUser: json["id_user"],
        idDelivery: json["id_delivery"],
        idAddress: json["id_address"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        status: json["status"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "id_delivery": idDelivery,
        "id_address": idAddress,
        "lat": lat,
        "lng": lng,
        "status": status,
        "timestamp": timestamp,
      };
}
