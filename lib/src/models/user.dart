import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String email;
  String name;
  String lastname;
  String phone;
  String password;
  String sessionToken;
  String image;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.lastname,
    required this.phone,
    required this.password,
    required this.sessionToken,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        password: json["password"],
        sessionToken: json["session_token"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "password": password,
        "session_token": sessionToken,
        "image": image,
      };
}
