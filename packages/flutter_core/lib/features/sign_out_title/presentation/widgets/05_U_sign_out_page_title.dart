
// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// Hardened signOutPageTitle
class Signoutpagetitle extends StatelessWidget {
  const Signoutpagetitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrimeCareResponsiveKpiGrid(
      title: 'signOutPageTitle',
      children: [
        PrimeCareCard(child: Text('Operational Sector: signOutPageTitle')),
      ],
    );
  }
}
