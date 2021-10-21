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
  // String image;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.lastname,
    required this.phone,
    required this.password,
    required this.sessionToken,
    // required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"].toString(),
        name: json["name"].toString(),
        lastname: json["lastname"].toString(),
        email: json["email"].toString(),
        phone: json["phone"].toString(),
        password: json["password"].toString(),
        sessionToken: json["session_token"].toString(),
        // image: json["image"] ?? '-',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "password": password,
        "sessionToken": sessionToken,
        // "image": image,
      };
}
