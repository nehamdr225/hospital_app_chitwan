abstract class HospitalInquiryModel {
  String userId;
  String hospitalId;
  String inquiry;
  String phone;
}

class HospitalInquiry implements HospitalInquiryModel {
  String userId;
  String hospitalId;
  String inquiry;
  String phone;

  HospitalInquiry({
    this.phone,
    this.inquiry,
    this.hospitalId,
    this.userId,
  });

  Map<String, String> toJson() => {
        'inquiry': inquiry,
        'phone': phone,
        'hospitalId': hospitalId,
        if (userId != null) 'userId': userId,
      };

  HospitalInquiry.fromJson(json)
      : inquiry = json['inquiry'],
        phone = json['phone'],
        hospitalId = json['hospitalId'],
        userId = json['userId'];
}
