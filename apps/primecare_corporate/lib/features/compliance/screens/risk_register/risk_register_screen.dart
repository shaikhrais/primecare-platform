import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/risk_register_header_section.dart';
import 'sections/risk_register_content_summary_section.dart';
import 'sections/risk_register_primary_content_section.dart';
import 'sections/risk_register_action_bar_section.dart';

class RiskRegisterScreen extends StatelessWidget {
  const RiskRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'risk_register',
      title: 'Risk Register',
      child: Column(
        children: const [
          const RiskRegisterHeaderSection(),
          const RiskRegisterContentSummarySection(),
          const RiskRegisterPrimaryContentSection(),
          const RiskRegisterActionBarSection(),
        ],
      ),
    );
  }
}
