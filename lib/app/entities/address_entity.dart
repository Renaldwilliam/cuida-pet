import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AddressEntity {
  final int? id;
  final String address;
  final double lat;
  final double lng;
  final String addtional;
  AddressEntity({
    this.id,
    required this.address,
    required this.lat,
    required this.lng,
    required this.addtional,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'lat': lat.toString(),
      'lng': lng.toString(),
      'addtional': addtional,
    };
  }

  factory AddressEntity.fromMap(Map<String, dynamic> map) {
    return AddressEntity(
      id: map['id'] != null ? map['id'] as int : null,
      address: (map['address'] ?? '') as String,
      lat: double.parse(map['lat'] ?? '0.0'),
      lng: double.parse(map['lng'] ?? '0.0'),
      addtional: (map['addtional'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressEntity.fromJson(String source) => AddressEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  AddressEntity copyWith({
    int? id,
    String? address,
    double? lat,
    double? lng,
    String? addtional,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      addtional: addtional ?? this.addtional,
    );
  }

  @override
  String toString() {
    return 'AddressEntity(id: $id, address: $address, lat: $lat, lng: $lng, addtional: $addtional)';
  }
}
