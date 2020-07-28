abstract class FavouriteModel {
  String id;
  String userId;
  String doctorId;
  String timestamp;
}

class Favourite implements FavouriteModel {
  String id;
  String userId;
  String doctorId;
  String timestamp;

  Favourite({
    this.id,
    this.userId,
    this.doctorId,
    this.timestamp,
  });

  Favourite.fromJson(json)
      : this.id = json['id'],
        this.userId = json['userId'],
        this.doctorId = json['doctorId'],
        this.timestamp = json['timestamp'];

  Map<String, String> toJson() => {
        if (this.id != null) 'id': this.id,
        'userId': userId,
        'doctorId': doctorId,
        'timestamp': timestamp,
      };
}
