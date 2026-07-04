import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_payments_header_section.dart';
import 'sections/patient_payments_content_summary_section.dart';
import 'sections/patient_payments_primary_content_section.dart';
import 'sections/patient_payments_action_bar_section.dart';

class PatientPaymentsScreen extends StatelessWidget {
  const PatientPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_payments',
      title: 'Patient Payments',
      child: Column(
        children: const [
          const PatientPaymentsHeaderSection(),
          const PatientPaymentsContentSummarySection(),
          const PatientPaymentsPrimaryContentSection(),
          const PatientPaymentsActionBarSection(),
        ],
      ),
    );
  }
}
