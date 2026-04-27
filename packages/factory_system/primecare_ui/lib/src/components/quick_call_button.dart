// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

class QuickCallButton extends StatelessWidget {
  const QuickCallButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: PrimeCareColors.emerald,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.videocam, color: PrimeCareColors.emerald),
      ),
      onPressed: () {},
    );
  }
}
