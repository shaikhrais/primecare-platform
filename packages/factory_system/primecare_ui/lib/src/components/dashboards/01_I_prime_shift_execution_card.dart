import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_adapters/src/infrastructure/01_I_telemetry_service.dart';
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:primecare_ui/src/components/01_I_primecare_card.dart';
import 'package:primecare_ui/src/components/01_I_primecare_button.dart';

class PrimeShiftExecutionCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareCard(
      backgroundColor: isShiftActive
          ? Theme.of(context).primaryColorLight
          : PrimeCareColors.white,
      child: Column(
        children: [
          Text(
            isShiftActive
                ? 'Active Client: $activeClientName'
                : 'Next Shift: $activeClientName',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (isShiftActive) ...[
            const SizedBox(height: 12),
            Text(
              '⏱ $formattedTime',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w900,
                color: Colors.indigo,
              ),
            ),
          ],
          const SizedBox(height: 20),
          PrimeCareButton(
            label: isShiftActive ? 'End Shift' : 'Locate & Start Shift',
            icon: isShiftActive ? Icons.stop_circle : Icons.play_circle_fill,
            isFullWidth: true,
            type: isShiftActive
                ? PrimeCareButtonType.secondary
                : PrimeCareButtonType.primary,
            onPressed: () {
              ref
                  .read(executionGateProvider)
                  .passGate(
                    ExecutionGateCategory.navigationLayer,
                    'Shift Toggle: ${isShiftActive ? 'ENDING' : 'STARTING'}',
                    metadata: {'clientName': activeClientName},
                  );
              onToggleShift();
            },
          ),
        ],
      ),
    );
  }
}
