import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unisq_project/Model/route_model.dart';
import 'package:unisq_project/pages/bus_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unisq_project/pages/seat_selection.dart';

import 'landing_screen.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});
  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomeScreen> {

  Widget homeImage(String imageName)
  {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Image.asset(imageName, width: 150.0, height: 150.0, fit: BoxFit.fill,),
    );
  }
  User? user = FirebaseAuth.instance.currentUser;
  int index = 0;
  final _homeMenuList = const <Widget>[HomeMenu(), HomeActivity(), HomeNotification()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title),
      ),

      drawer: Drawer(
        backgroundColor: Colors.redAccent,
        shadowColor: Colors.blueGrey,
        elevation: 2.0,
        child: SafeArea(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text('$user.displayName', style: const TextStyle(color: Colors.white, fontSize: 20),),
                  accountEmail: Text('$user.email', style: const TextStyle(color: Colors.white70, fontSize: 18),),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage("https://appmaking.co/wp-content/uploads/2021/08/appmaking-logo-colored.png"),
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("https://appmaking.co/wp-content/uploads/2021/08/appmaking-logo-colored.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('My Profile', style: TextStyle(color: Colors.black, fontSize: 20),),
                onTap: (){},
              ),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('Payment Methods', style: TextStyle(color: Colors.black, fontSize: 20),),
                onTap: (){},
              ),
              ListTile(
                leading: const Icon(Icons.bus_alert),
                title: const Text('My Ticket', style: TextStyle(color: Colors.black, fontSize: 20),),
                onTap: (){},
              ),
              ListTile(
                leading: const Icon(Icons.support_agent),
                title: const Text('Support', style: TextStyle(color: Colors.black, fontSize: 20),),
                onTap: (){},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign Out', style: TextStyle(color: Colors.black, fontSize: 20),),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>const LandingScreen())
                  );
                },
              ),
            ],
          )
        ),
      ),
      body: _homeMenuList[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        elevation: 2.0,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.black,
        unselectedFontSize: 18,
        selectedFontSize: 20,
        currentIndex: index,
        onTap: (x){
          setState(() {
            index =x;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
            label: 'Ticket'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
            label: 'Notifications'
          ),
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  var routeFrom, routeTo, routeStart;
  var setRouteFrom = true, setRouteTo = true, setRouteStart = true;
  @override
  void initState()
  {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [Colors.orange, Colors.deepOrangeAccent, Colors.red, Colors.redAccent]
          )
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text('From', style: TextStyle(fontSize: 25.0),),
              const SizedBox(width:15),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('routes').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
                  if(!snapshot.hasData) {
                    return Container();
                  }
                  if(snapshot.connectionState== ConnectionState.waiting) {
                    return const Text('Loading');
                  }
                  if(setRouteFrom)
                    {
                      final data_ = snapshot.data!.docs[0].data() as Map<String, dynamic>;
                      routeFrom = data_['routeFrom'].toString();
                    }
                  return DropdownButton(
                    isExpanded:false,
                      value: routeFrom,
                      items: snapshot.data!.docs.map((DocumentSnapshot document){
                        final dataNew = document.data()! as Map<String, dynamic>;
                        return DropdownMenuItem(
                          value: dataNew['routeFrom'].toString(),
                            child: Text(dataNew['routeFrom'].toString(), style: const TextStyle(fontSize: 25.0),)
                        );
                      }).toList(),
                      onChanged: (value){
                      setState(() {
                        routeFrom = value;
                        setRouteFrom = false;
                        setRouteTo = true;
                      });
                      }
                  );
                },
              )
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: <Widget>[
              const Text('To', style: TextStyle(fontSize: 25.0),),
              const SizedBox(width:15),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('routes').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
                  if(!snapshot.hasData) {
                    return Container();
                  }
                  if(snapshot.connectionState== ConnectionState.waiting) {
                    return const Text('Loading');
                  }
                  if(setRouteTo)
                  {
                    final data_ = snapshot.data!.docs[0].data() as Map<String, dynamic>;
                    routeTo = data_['routeTo'].toString();
                  }
                  return DropdownButton(
                      isExpanded:false,
                      value: routeTo,
                      items: snapshot.data!.docs.map((DocumentSnapshot document){
                        final dataNew = document.data()! as Map<String, dynamic>;
                        return DropdownMenuItem(
                            value: dataNew['routeTo'].toString(),
                            child: Text(dataNew['routeTo'].toString(), style: const TextStyle(fontSize: 25.0),)
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          routeTo = value;
                          setRouteFrom = false;
                          setRouteTo = false;
                        });
                      }
                  );
                },
              )
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(
                    elevation: 1.0,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: (){
                    Navigator.push(context,
                       // MaterialPageRoute(builder: (context)=> BusList(routeFrom: routeFrom,routeTo: routeTo,))
                        MaterialPageRoute(builder: (context)=> const SeatSelection())
                    );
                  },
                  child: const Text('Search Bus', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),)
              )
            ],
          ),
        ],
      ),
    );
  }
}
class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static const CameraPosition _kDirection = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: _goToDirection,
              label: const Text('Navigate'),
              icon: const Icon(Icons.directions_boat),
          ),
    );
  }
  Future<void> _goToDirection() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kDirection));
  }
}
class HomeNotification extends StatefulWidget {
  const HomeNotification({super.key});

  @override
  State<HomeNotification> createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



