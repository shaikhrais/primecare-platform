// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// Hardened fuse_splash_screen
class FuseSplashScreen extends StatelessWidget {
  const FuseSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: 'fuse_splash_screen',
      child: const PrimeCareCard(child: Text('Operational Sector: fuse_splash_screen')),
    );
  }
}
