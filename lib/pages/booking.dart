import 'package:flutter/material.dart';
import 'package:unisq_project/pages/bus_seats.dart';

import 'design_file.dart';
class BusBooking extends StatefulWidget {
  const BusBooking({super.key, required this.b});
  final String b;

  @override
  State<BusBooking> createState() => _BusBookingState();
}

class _BusBookingState extends State<BusBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              color: const Color.fromRGBO(255, 205, 5, 1),
              child: Stack(
                children: [
                  Positioned(
                    left: 15,
                    top: 24,
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('assets/images/search_bus.jpg')),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Travellers',
                            style: Design.textToStyle(24, FontWeight.w700)),
                        Container(
                          height: 20,
                        ),
                        Text('Luxury  $widget.b (2+2)',
                            style: Design.textToStyle((18), FontWeight.w400))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 7,
            ),
            Text('Choose seats your seat',
                style: Design.textToStyle(18, FontWeight.w700)),
            Container(
              height: 7,
            ),
             Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const BusSeats()),
            const SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
