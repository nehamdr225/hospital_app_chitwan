abstract class HospitalInquiryModel {
  String inquiry;
  String phoneNum;
}

class HospitalInquiry implements HospitalInquiryModel {
  String inquiry;
  String phoneNum;

  HospitalInquiry(this.phoneNum, this.inquiry);

  Map<String, dynamic> toJson() => {
        'inquiry': inquiry,
        'phoneNum': phoneNum,
      };

  HospitalInquiry.fromJson(json)
      : inquiry = json['inquiry'],
        phoneNum = json['phoneNum'];
}
