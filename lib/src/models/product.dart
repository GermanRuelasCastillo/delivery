import 'dart:convert';

Producto productoFromJson(String str) => Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

class Producto {
  Producto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.idCategory,
  });

  String id;
  String name;
  String description;
  double price;
  String image1;
  String image2;
  String image3;
  String idCategory;
  dynamic quantity;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"].toDouble(),
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        idCategory: json["id_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "id_category": idCategory,
      };
}
