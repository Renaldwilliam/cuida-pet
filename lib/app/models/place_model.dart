// ignore_for_file: public_member_api_docs, sort_constructors_first

class PlaceModel {
  String address;
  double lat;
  double log;
  PlaceModel({
    required this.address,
    required this.lat,
    required this.log,
  });

  @override 
  String toString() => 'PlaceModel(address: $address, lat: $lat, log: $log)';
}
