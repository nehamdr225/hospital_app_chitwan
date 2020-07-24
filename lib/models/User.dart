abstract class UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String role;
  String address;
}

class User implements UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String role;
  String address;

  User({this.uid, this.name, this.email, this.phone, this.role});

  User.fromJson(json)
      : this.uid = json['id'],
        this.name = json['name'],
        this.email = json['email'],
        this.phone = json['phone'] ?? null,
        this.address = json['address'] ?? null,
        this.role = json['role'] ?? null;

  Map toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        if (address != null) 'address': address
      };
}
