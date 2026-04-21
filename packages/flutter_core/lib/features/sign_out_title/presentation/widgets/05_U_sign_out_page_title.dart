// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// Hardened sign_out_page_title
class SignOutPageTitle extends StatelessWidget {
  const SignOutPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: 'sign_out_page_title',
      child: const PrimeCareCard(child: Text('Operational Sector: sign_out_page_title')),
    );
  }
}
