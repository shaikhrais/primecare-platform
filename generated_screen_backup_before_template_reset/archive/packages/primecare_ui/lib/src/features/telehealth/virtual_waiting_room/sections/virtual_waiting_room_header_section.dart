import 'package:flutter/material.dart';

class VirtualWaitingRoomHeaderSection extends StatelessWidget {
  const VirtualWaitingRoomHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('virtual_waiting_room_header-section'),
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
