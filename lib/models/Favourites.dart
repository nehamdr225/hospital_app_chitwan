enum FavouriteType { Doctor, Pharmacy, Lab }

extension on FavouriteType {
  String get name => this.toString().split('.').last;
}

FavouriteType enumType(String type) {
  if (type == "Doctor")
    return FavouriteType.Doctor;
  else if (type == "Pharmacy") return FavouriteType.Pharmacy;
  return FavouriteType.Lab;
}

abstract class FavouriteModel {
  String id;
  String userId;
  String favId;
  String timestamp;
  FavouriteType type;
}

class Favourite implements FavouriteModel {
  String id;
  String userId;
  String favId;
  String timestamp;
  FavouriteType type;

  Favourite({
    this.id,
    this.userId,
    this.favId,
    this.timestamp,
    this.type,
  });

  Favourite.fromJson(json)
      : this.id = json['id'],
        this.userId = json['userId'],
        this.favId = json['favId'],
        this.timestamp = json['timestamp'],
        this.type = enumType(json['type']);

  Map<String, String> toJson() => {
        if (this.id != null) 'id': this.id,
        'userId': userId,
        'favId': favId,
        'timestamp': timestamp,
        'type': type.name,
      };
}
