
class TripModel
{
  final String id;
  final String userId;
  final String busId;
  final String active;
  TripModel({required this.id, required this.userId, required this.busId, required this.active});

  factory TripModel.fromJson(Map<String, dynamic>json){
    return TripModel(
        id: json["id"],
        userId: json["userId"],
        busId: json["busId"],
      active: json["active"],
    );
  }
  static List<TripModel>fromJsonList(List list)
  {
    return list.map((item)=>TripModel.fromJson(item)).toList();
  }
}