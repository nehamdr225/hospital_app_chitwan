abstract class UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String type;
}

class User implements UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String type;

  User({this.uid, this.name, this.email, this.phone, this.type});

  User.fromJson(json)
      : this.uid = json['id'],
        this.name = json['name'],
        this.email = json['email'],
        this.phone = json['phone'] ?? null,
        this.type = json['type'] ?? null;
}
