abstract class PharmacyAppointmentModel {
  String name;
  String phone;
  DateTime timestamp;
  String address;
  String image;
  String medicine;
  String pickUp;
  String userId;
  String pharmacyId;
  String pharmacyName;
}

class PharmacyAppointment implements PharmacyAppointmentModel {
  String name;
  String phone;
  DateTime timestamp;
  String address;
  String image;
  String medicine;
  String pickUp;
  String userId;
  String pharmacyId;
  String pharmacyName;

  PharmacyAppointment(
      {this.timestamp,
      this.address,
      this.name,
      this.phone,
      this.image,
      this.medicine,
      this.pickUp,
      this.userId,
      this.pharmacyId,
      this.pharmacyName});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'timestamp': timestamp.toIso8601String(),
        'address': address,
        'pickUp': pickUp,
        'userId': userId,
        'pharmacyId': pharmacyId,
        'pharmacyName': pharmacyName,
        if (image != null) 'image': image,
        if (medicine != null) 'medicine': medicine,
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
        pharmacyName = json['pharmacyName'];
}
