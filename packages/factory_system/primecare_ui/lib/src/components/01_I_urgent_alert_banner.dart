// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';

class UrgentAlertBanner extends StatelessWidget {
  final String message;
  const UrgentAlertBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: PrimeCareColors.rose,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: PrimeCareColors.rose),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: PrimeCareColors.rose),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: PrimeCareColors.rose,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
