import 'package:flutter/material.dart';
import 'prime_avatar.dart';

class DragAssignWidget extends StatelessWidget {
  const DragAssignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: 'PSW_123',
      feedback: const Material(
        color: Colors.transparent,
        child: PrimeAvatar(fallbackInitials: 'PSW'),
      ),
      child: const PrimeAvatar(fallbackInitials: 'PSW'),
    );
  }
}
