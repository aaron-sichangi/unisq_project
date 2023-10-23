import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:unisq_project/pages/bus_details.dart';

import '../Model/bus_model.dart';
class BusList extends StatefulWidget {
  const BusList({super.key, required this.routeFrom, required this.routeTo});
  final String routeFrom;
  final String routeTo;

  @override
  State<BusList> createState() => _BusListState();
}

class _BusListState extends State<BusList> {
  List<int>items = [1,2,4,4,5];
  CollectionReference referenceRoutes = FirebaseFirestore.instance.collection('routes');
  //final document1 =


  @override
  Widget build(BuildContext context) {
    final routeRef = FirebaseFirestore.instance.collection('routes');
        routeRef.where('routeFrom', whereIn: [widget.routeFrom]);
        routeRef.where('routeTo', whereIn: [widget.routeTo]);
    //final future = routeRef.get();

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        //stream: FirebaseFirestore.instance.collection('routes').where('routeFrom', whereIn: [widget.routeFrom]).where('routeTo', whereIn: [widget.routeTo]).snapshots(),
        stream:routeRef.snapshots(),
        builder:  (BuildContext context, AsyncSnapshot snapshot){
          if (!snapshot.hasData) {
            return const Text('Loading');
          }
          if(snapshot.connectionState== ConnectionState.waiting) {
            return Container(
              height: 200.0,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
              ),
            );
          }
          else{
            return SingleChildScrollView(
              child: ListView(
                children: _buildList(context, snapshot.data.docs())
              ),
            );
          }
          },
      ),
    );
  }
  List<ListTile>_buildList(BuildContext context, List<dynamic>snapshot)
  {
    return snapshot.map((data)=>_buildListItem(context,data)).toList();
  }
  ListTile _buildListItem(BuildContext context, data)
  {
    final busRecord = BusModel.fromJson(data);
    return ListTile(
      leading: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 44,
          minWidth: 44,
          maxHeight: 64,
          maxWidth: 64,
        ),
        child: Image.asset('assets/images/bus_booking_image.jpg',fit: BoxFit.fill,),
      ),
      title: Text(busRecord.busGroup, style: const TextStyle(color: Colors.black, fontSize: 25),),
      subtitle: Text("$busRecord.busClass     $busRecord.fare", style: const TextStyle(color: Colors.black, fontSize: 20),),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> BusDetails(id: busRecord.id.toString()))
        );
      },
    );
  }
}



