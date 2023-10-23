
class BusModel{
  final String id;
  final String fare;
  final String busClass;
  final String busGroup;
  final String locationId;
  BusModel({required this.id, required this.fare, required this.busClass, required this.busGroup, required this.locationId});

  factory BusModel.fromJson(Map<String, dynamic>json){
    return BusModel(
      id: json["id"],
      fare: json["fare"],
      busClass: json["busClass"],
      busGroup: json["busGroup"],
      locationId: json["locationId"]
    );
  }
  static List<BusModel>fromJsonArray(List<dynamic>jsonArray)
  {
    List<BusModel>busModelFromJson = [];
    for(var item in jsonArray)
      {
        busModelFromJson.add(BusModel.fromJson(item));
      }
    return busModelFromJson;
  }
  Map<String, dynamic>toMap()=>{
    "id":id,
    "fare": fare,
    "busClass": busClass,
    "busGroup": busGroup,
    "locationId": locationId
  };
}