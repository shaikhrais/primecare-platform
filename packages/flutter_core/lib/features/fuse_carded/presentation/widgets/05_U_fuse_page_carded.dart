// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// Hardened fuse_page_carded
class FusePageCarded extends StatelessWidget {
  const FusePageCarded({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: 'fuse_page_carded',
      child: const PrimeCareCard(child: Text('Operational Sector: fuse_page_carded')),
    );
  }
}
