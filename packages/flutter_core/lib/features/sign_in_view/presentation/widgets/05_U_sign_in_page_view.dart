// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// Hardened sign_in_page_view
class SignInPageView extends StatelessWidget {
  const SignInPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: 'sign_in_page_view',
      child: const PrimeCareCard(child: Text('Operational Sector: sign_in_page_view')),
    );
  }
}
