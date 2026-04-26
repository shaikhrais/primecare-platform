import 'package:flutter/material.dart';
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:primecare_ui/src/components/01_I_primecare_progress_bar.dart';

class PrimeComplianceTracker extends StatelessWidget {
  final double progress;
  final String percentageText;
  final Color activeColor;

  const PrimeComplianceTracker({
    super.key,
    required this.progress,
    required this.percentageText,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Compliance Tracker',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: PrimeCareColors.slate400,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: PrimeCareProgressBar(
                progress: progress,
                activeColor: activeColor,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              percentageText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
