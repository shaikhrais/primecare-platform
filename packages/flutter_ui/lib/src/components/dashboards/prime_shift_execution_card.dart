import 'package:flutter/material.dart';
import 'package:flutter_ui/flutter_ui.dart';

class PrimeShiftExecutionCard extends StatelessWidget {
  final bool isShiftActive;
  final String formattedTime;
  final String activeClientName;
  final VoidCallback onToggleShift;

  const PrimeShiftExecutionCard({
    super.key,
    required this.isShiftActive,
    required this.formattedTime,
    required this.activeClientName,
    required this.onToggleShift,
  });

  @override
  Widget build(BuildContext context) {
    return PrimeCareCard(
      backgroundColor: isShiftActive ? Theme.of(context).primaryColorLight : Colors.white,
      child: Column(
        children: [
          Text(isShiftActive ? 'Active Client: $activeClientName' : 'Next Shift: $activeClientName', overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (isShiftActive) ...[
            const SizedBox(height: 12),
            Text('⏱ $formattedTime', overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: Colors.indigo)),
          ],
          const SizedBox(height: 20),
          PrimeCareButton(
            label: isShiftActive ? 'End Shift' : 'Locate & Start Shift',
            icon: isShiftActive ? Icons.stop_circle : Icons.play_circle_fill,
            isFullWidth: true,
            type: isShiftActive ? PrimeCareButtonType.secondary : PrimeCareButtonType.primary,
            onPressed: onToggleShift,
          ),
        ],
      ),
    );
  }
}
