import 'package:flutter/material.dart';
import 'prime_card.dart';

class TinderStyleSwipeApprovals extends StatelessWidget {
  const TinderStyleSwipeApprovals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('swipe_card'),
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.check, color: Colors.white, size: 40),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.close, color: Colors.white, size: 40),
      ),
      child: const PrimeCard(
        child: SizedBox(
          height: 300,
          width: double.infinity,
          child: Center(
            child: Text(
              'Timesheet #492\nSwipe Right to Approve',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
