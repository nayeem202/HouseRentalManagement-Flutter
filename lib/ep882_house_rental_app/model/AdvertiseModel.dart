import 'package:client_mobile/ep882_house_rental_app/model/user.dart';

class AdvertiseModel{

  late int advertisingId;
  late String location;
  late String type;
  late String status;
  late int bedrooms;
  late int bathrooms;
  late int price;
  late int sqft;
  late String additionalinformation;
  late String images;
  late String imagesUri;

  late String img2;
  late String imgUri2;

  late String img3;
  late String imgUri3;

  late String video;
  late String videoType;

  late double lat;
  late double lng;
  late UserModel user;

//<editor-fold desc="Data Methods">

  AdvertiseModel({
    required this.advertisingId,
    required this.location,
    required this.type,
    required this.status,
    required this.bedrooms,
    required this.bathrooms,
    required this.price,
    required this.sqft,
    required this.additionalinformation,
    required this.images,
    required this.imagesUri,
    required this.img2,
    required this.imgUri2,
    required this.img3,
    required this.imgUri3,
    required this.video,
    required this.videoType,
    required this.lat,
    required this.lng,
    required this.user,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdvertiseModel &&
          runtimeType == other.runtimeType &&
          advertisingId == other.advertisingId &&
          location == other.location &&
          type == other.type &&
          status == other.status &&
          bedrooms == other.bedrooms &&
          bathrooms == other.bathrooms &&
          price == other.price &&
          sqft == other.sqft &&
          additionalinformation == other.additionalinformation &&
          images == other.images &&
          imagesUri == other.imagesUri &&
          img2 == other.img2 &&
          imgUri2 == other.imgUri2 &&
          img3 == other.img3 &&
          imgUri3 == other.imgUri3 &&
          video == other.video &&
          videoType == other.videoType &&
          lat == other.lat &&
          lng == other.lng);

  @override
  int get hashCode =>
      advertisingId.hashCode ^
      location.hashCode ^
      type.hashCode ^
      status.hashCode ^
      bedrooms.hashCode ^
      bathrooms.hashCode ^
      price.hashCode ^
      sqft.hashCode ^
      additionalinformation.hashCode ^
      images.hashCode ^
      imagesUri.hashCode ^
      img2.hashCode ^
      imgUri2.hashCode ^
      img3.hashCode ^
      imgUri3.hashCode ^
      video.hashCode ^
      videoType.hashCode ^
      lat.hashCode ^
      lng.hashCode;

  @override
  String toString() {
    return 'AdvertiseModel{' +
        ' advertisingId: $advertisingId,' +
        ' location: $location,' +
        ' type: $type,' +
        ' status: $status,' +
        ' bedrooms: $bedrooms,' +
        ' bathrooms: $bathrooms,' +
        ' price: $price,' +
        ' sqft: $sqft,' +
        ' additionalinformation: $additionalinformation,' +
        ' images: $images,' +
        ' imagesUri: $imagesUri,' +
        ' img2: $img2,' +
        ' imgUri2: $imgUri2,' +
        ' img3: $img3,' +
        ' imgUri3: $imgUri3,' +
        ' video: $video,' +
        ' videoType: $videoType,' +
        ' lat: $lat,' +
        ' lng: $lng,' +
        '}';
  }

  AdvertiseModel copyWith({
    int? advertisingId,
    String? location,
    String? type,
    String? status,
    int? bedrooms,
    int? bathrooms,
    int? price,
    int? sqft,
    String? additionalinformation,
    String? images,
    String? imagesUri,
    String? img2,
    String? imgUri2,
    String? img3,
    String? imgUri3,
    String? video,
    String? videoType,
    double? lat,
    double? lng,
  }) {
    return AdvertiseModel(
      advertisingId: advertisingId ?? this.advertisingId,
      location: location ?? this.location,
      type: type ?? this.type,
      status: status ?? this.status,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      price: price ?? this.price,
      sqft: sqft ?? this.sqft,
      additionalinformation:
          additionalinformation ?? this.additionalinformation,
      images: images ?? this.images,
      imagesUri: imagesUri ?? this.imagesUri,
      img2: img2 ?? this.img2,
      imgUri2: imgUri2 ?? this.imgUri2,
      img3: img3 ?? this.img3,
      imgUri3: imgUri3 ?? this.imgUri3,
      video: video ?? this.video,
      videoType: videoType ?? this.videoType,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      user: user
      //user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'advertisingId': this.advertisingId,
      'location': this.location,
      'type': this.type,
      'status': this.status,
      'bedrooms': this.bedrooms,
      'bathrooms': this.bathrooms,
      'price': this.price,
      'sqft': this.sqft,
      'additionalinformation': this.additionalinformation,
      'images': this.images,
      'imagesUri': this.imagesUri,
      'img2': this.img2,
      'imgUri2': this.imgUri2,
      'img3': this.img3,
      'imgUri3': this.imgUri3,
      'video': this.video,
      'videoType': this.videoType,
      'lat': this.lat,
      'lng': this.lng,
    };
  }

  factory AdvertiseModel.fromMap(Map<String, dynamic> map) {
    return AdvertiseModel(
      advertisingId: map['advertisingId'] as int,
      location: map['location'] as String,
      type: map['type'] as String,
      status: map['status'] as String,
      bedrooms: map['bedrooms'] as int,
      bathrooms: map['bathrooms'] as int,
      price: map['price'] as int,
      sqft: map['sqft'] as int,
      additionalinformation: map['additionalinformation'] as String,
      images: map['images'] as String,
      imagesUri: map['imagesUri'] as String,
      img2: map['img2'] as String,
      imgUri2: map['imgUri2'] as String,
      img3: map['img3'] as String,
      imgUri3: map['imgUri3'] as String,
      video: map['video'] as String,
      videoType: map['videoType'] as String,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      user: UserModel.fromMap(map['user'])
    );
  }

//</editor-fold>
}

