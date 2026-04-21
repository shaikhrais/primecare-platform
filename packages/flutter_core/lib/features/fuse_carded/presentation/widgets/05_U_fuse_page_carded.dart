
// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// Hardened fusePageCarded
class Fusepagecarded extends StatelessWidget {
  const Fusepagecarded({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrimeCareResponsiveKpiGrid(
      title: 'fusePageCarded',
      children: [
        PrimeCareCard(child: Text('Operational Sector: fusePageCarded')),
      ],
    );
  }
}
