// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';

class LiveGeolocationMapLoader extends StatelessWidget {
  const LiveGeolocationMapLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: PrimeCareColors.emerald,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PrimeCareColors.emerald),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: PrimeCareColors.emerald, size: 32),
            const SizedBox(height: 8),
            Text(
              '0.2 miles from client',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: PrimeCareColors.emerald,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
