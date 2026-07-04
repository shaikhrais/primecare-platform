import 'package:flutter/material.dart';

class SchedulerShiftsHeaderSection extends StatelessWidget {
  const SchedulerShiftsHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('scheduler_shifts_header-section'),
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
