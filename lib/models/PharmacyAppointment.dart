abstract class PharmacyAppointmentModel {
  String id;
  String name;
  String phone;
  String timestamp;
  String address;
  String image;
  String medicine;
  String pickUp;
  String userId;
  String pharmacyId;
  String pharmacyName;
  String status;
  String remark;
}

class PharmacyAppointment implements PharmacyAppointmentModel {
  String id;
  String name;
  String phone;
  String timestamp;
  String address;
  String image;
  String medicine;
  String pickUp;
  String userId;
  String pharmacyId;
  String pharmacyName;
  String status;
  String remark;

  PharmacyAppointment(
      {this.id,
      this.timestamp,
      this.address,
      this.name,
      this.phone,
      this.image,
      this.medicine,
      this.pickUp,
      this.userId,
      this.pharmacyId,
      this.pharmacyName,
      this.status,
      this.remark});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'timestamp': timestamp,
        'address': address,
        'pickUp': pickUp,
        'userId': userId,
        'pharmacyId': pharmacyId,
        'pharmacyName': pharmacyName,
        if (image != null) 'image': image,
        if (medicine != null) 'medicine': medicine,
        if (id != null) 'id': id,
        if (status != null) 'status': status,
        if (remark != null) 'remark': remark,
      };

  PharmacyAppointment.fromJson(json)
      : name = json['name'],
        timestamp = json['timestamp'],
        address = json['address'],
        phone = json['phone'],
        medicine = json['medicine'],
        pickUp = json['pickUp'],
        userId = json['userId'],
        pharmacyId = json['pharmacyId'],
        pharmacyName = json['pharmacyName'],
        id = json['id'],
        status = json['status'],
        remark = json['remark'],
        image = json['image'];
}
