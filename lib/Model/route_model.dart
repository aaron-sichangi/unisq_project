
import 'bus_model.dart';

class RouteModel{
  List<BusModel>? busResult;
  final String id;
  final String routeFrom;
  final String routeTo;
  final String routeStart;
  final String routeArrive;
  RouteModel({
    required this.id,
    required this.routeFrom,
    required this.routeTo,
    required this.routeStart,
    required this.routeArrive,
    this.busResult
  });
  factory RouteModel.fromMap(map){
    return RouteModel(
        id: map["id"],
        routeFrom: map["routeFrom"],
      routeTo: map["routeTo"],
      routeStart: map["routeStart"],
      routeArrive: map["routeArrive"],
        busResult: BusModel.fromJsonArray(map['buses'])
    );
  }
  Map<String,dynamic>toMap(){
    return{
      'buses':busResult
    };
  }
  /*static List<RouteModel> fromJsonList(List list)
  {
    return list.map((item)=>RouteModel.fromJson(item)).toList();
  }*/
}