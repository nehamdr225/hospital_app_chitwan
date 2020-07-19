class BloodRequest {
  String firstName;
  String lastName;
  String phoneNum;
  DateTime date;
  String time;
  String address;
  String bloodGroup;

  BloodRequest(this.date, this.time, this.address, this.firstName,
      this.lastName, this.phoneNum, this.bloodGroup);

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'phoneNum': phoneNum,
        'date': date,
        'lastName': lastName,
        'address': address,
        'bloodGroup': bloodGroup
      };

  BloodRequest.fromJson(json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        date = json['date'].toDate(),
        address = json['address'],
        phoneNum = json['phoneNum'],
        bloodGroup = json['bloodGroup'];
}
