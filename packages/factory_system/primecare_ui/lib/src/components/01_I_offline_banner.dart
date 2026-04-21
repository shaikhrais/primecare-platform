// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFEF4444), // Critical Red
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.wifi_off_rounded, color: PrimeCareColors.white, size: 16),
          SizedBox(width: 8),
          Text(
            'OFFLINE - Checkouts & Inputs queued locally',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: PrimeCareColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
