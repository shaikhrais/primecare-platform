import 'package:flutter/material.dart';

class PswShiftTrackerHeaderSection extends StatelessWidget {
  const PswShiftTrackerHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('psw_shift_tracker_header-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Header Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
