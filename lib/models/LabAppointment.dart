abstract class LabAppointmentModel {
  String id, uid, labId;
  String name;
  String phone;
  String timestamp;
  String address;
  String status;
  String remark;
  String email;
  String title;
  String image;
}

class LabAppointment implements LabAppointmentModel {
  String id, uid, labId;
  String name;
  String phone;
  String email;
  String timestamp;
  String address;
  String status;
  String remark;
  String title;
  String image;

  LabAppointment({
    this.id,
    this.uid,
    this.labId,
    this.timestamp,
    this.address,
    this.name,
    this.phone,
    this.image,
    this.status,
    this.remark,
    this.email,
    this.title,
  });

  Map<String, String> toJson() => {
        'name': name,
        'phone': phone,
        'timestamp': timestamp,
        'email': email,
        'title': title,
        'uid': uid,
        'labId': labId,
        if (address != null) 'address': address,
        if (image != null) 'image': image,
        if (id != null) 'id': id,
        if (status != null) 'status': status,
        if (remark != null) 'remark': remark,
      };

  LabAppointment.fromJson(json)
      : name = json['name'],
        timestamp = json['timestamp'],
        address = json['address'],
        phone = json['phone'],
        image = json['image'],
        id = json['id'],
        uid = json['uid'],
        labId = json['labId'],
        status = json['status'],
        email = json['email'],
        title = json['title'];
}
