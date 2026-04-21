// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// Hardened full_screen_toggle
class FullScreenToggle extends StatelessWidget {
  const FullScreenToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: 'full_screen_toggle',
      child: const PrimeCareCard(child: Text('Operational Sector: full_screen_toggle')),
    );
  }
}
