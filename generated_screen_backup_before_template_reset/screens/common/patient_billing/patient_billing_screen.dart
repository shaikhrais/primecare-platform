import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_billing_header_section.dart';
import 'sections/patient_billing_content_summary_section.dart';
import 'sections/patient_billing_primary_content_section.dart';
import 'sections/patient_billing_action_bar_section.dart';

class PatientBillingScreen extends StatelessWidget {
  const PatientBillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_billing',
      title: 'PatientBillingScreen',
      child: Column(
        children: const [
          const PatientBillingHeaderSection(),
          const PatientBillingContentSummarySection(),
          const PatientBillingPrimaryContentSection(),
          const PatientBillingActionBarSection(),
        ],
      ),
    );
  }
}
