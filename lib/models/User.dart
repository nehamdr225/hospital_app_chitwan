abstract class UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String role;
}

class User implements UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String role;

  User({this.uid, this.name, this.email, this.phone, this.role});

  User.fromJson(json)
      : this.uid = json['id'],
        this.name = json['name'],
        this.email = json['email'],
        this.phone = json['phone'] ?? null,
        this.role = json['role'] ?? null;

  Map toJson() => {'name': name, 'email': email, 'phone': phone, 'role': role};
}
