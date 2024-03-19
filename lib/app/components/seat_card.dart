import 'package:flutter/material.dart';
import '../models/seat.dart'; // Make sure to import the correct Seat model

class SeatCard extends StatelessWidget {
  final Seat seat;

  SeatCard({required this.seat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: seat.availability == '0' ? Colors.red : Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Seat Number: ${seat.seatNumber}',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
