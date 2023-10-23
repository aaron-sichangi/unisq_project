import 'package:flutter/material.dart';

class BusDetails extends StatefulWidget {
  const BusDetails({super.key, required this.id});
  final String id;
  @override
  State<BusDetails> createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      borderOnForeground: true,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 44,
                minWidth: 44,
                maxHeight: 64,
                maxWidth: 64,
              ),
              child: Image.asset('assets/images/bus_booking_image.jpg',fit: BoxFit.fill,),
            ),
            title: const Text("Name", style: TextStyle(color: Colors.black, fontSize: 25),),
            subtitle: const Text("busClass", style: TextStyle(color: Colors.black, fontSize: 20),),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> const BusDetails(id: 'id'))
              );
            },
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("From To: "),
              SizedBox(width: 8,),
              Text("data"),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("Journey date: "),
              SizedBox(width: 8,),
              Text("data"),
              SizedBox(width: 8,),
              Text("34", style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ],
      ),
    );
  }
}
