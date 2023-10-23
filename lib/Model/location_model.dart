class LocationModel{
  final String id;
  final String lat;
  final String long;
  LocationModel({required this.id, required this.lat, required this.long});
  factory LocationModel.fromJson(Map<String, dynamic>json){
    return LocationModel(
        id: json["id"],
        lat: json["lat"],
      long: json["long"]
    );
  }
  static List<LocationModel>fromJsonList(List list)
  {
    return list.map((item)=>LocationModel.fromJson(item)).toList();
  }
}