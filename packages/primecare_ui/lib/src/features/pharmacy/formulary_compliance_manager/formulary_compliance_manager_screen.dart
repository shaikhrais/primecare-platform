import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/formulary_compliance_manager_header_section.dart';
import 'sections/formulary_compliance_manager_form_body_section.dart';
import 'sections/formulary_compliance_manager_validation_messages_section.dart';
import 'sections/formulary_compliance_manager_action_bar_section.dart';

class FormularyComplianceManagerScreen extends StatelessWidget {
  const FormularyComplianceManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'formulary_compliance_manager',
      title: 'Formulary Compliance Manager',
      child: Column(
        children: const [
          const FormularyComplianceManagerHeaderSection(),
          const FormularyComplianceManagerFormBodySection(),
          const FormularyComplianceManagerValidationMessagesSection(),
          const FormularyComplianceManagerActionBarSection(),
        ],
      ),
    );
  }
}
