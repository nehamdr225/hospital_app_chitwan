abstract class HospitalPromoModel {
  String id;
  String hospitalId, hospital;
  String fromDate;
  String toDate;
  String description;
  String title;
  String image;
  bool isArchived;
}

class HospitalPromotion implements HospitalPromoModel {
  String id;
  String hospitalId;
  String fromDate;
  String toDate;
  String description;
  String title;
  String image;
  String hospital;
  bool isArchived;

  HospitalPromotion(
      {this.id,
      this.hospitalId,
      this.fromDate,
      this.description,
      this.title,
      this.toDate,
      this.isArchived,
      this.image,
      this.hospital});

  HospitalPromotion.fromJson(json)
      : this.id = json['id'],
        this.hospitalId = json['hospitalId'],
        this.fromDate = json['fromDate'],
        this.toDate = json['toDate'],
        this.description = json['description'],
        this.title = json['title'],
        this.isArchived = json['isArchived'],
        this.image = json['image'],
        this.hospital = json['hospital'];

  Map<String, dynamic> toJson() => {
        if (this.id != null) 'id': this.id,
        'isArchived': this.isArchived,
        'hospitalId': this.hospitalId,
        'fromDate': this.fromDate,
        'toDate': this.toDate,
        'title': this.title,
        'description': this.description,
        'image': this.image,
        'hospital': this.hospital,
      };
}
