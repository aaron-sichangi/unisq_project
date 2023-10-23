import 'package:flutter/material.dart';
import 'package:unisq_project/pages/booking.dart';

import 'design_file.dart';

class SeatSelection extends StatefulWidget {
  const SeatSelection({super.key});

  @override
  State<SeatSelection> createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BusBooking(b: "Comfort"))
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      width: 138,
                      height: 48,
                      decoration: Design.boxDecoration(),
                      child: const Center(
                          child: Text(
                            'Select Your Seat',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(9, 9, 9, 1),
                              fontFamily: 'Inter',
                              fontSize: 18,
                              letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
