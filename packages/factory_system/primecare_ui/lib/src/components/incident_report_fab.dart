// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

class IncidentReportFab extends StatelessWidget {
  const IncidentReportFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: PrimeCareColors.rose,
      icon: const Icon(Icons.warning, color: PrimeCareColors.white),
      label: const Text(
        'REPORT INCIDENT',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          color: PrimeCareColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
