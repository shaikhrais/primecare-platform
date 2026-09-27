import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/inpatient_pharmacy_queue_header_section.dart';
import 'sections/inpatient_pharmacy_queue_content_summary_section.dart';
import 'sections/inpatient_pharmacy_queue_primary_content_section.dart';
import 'sections/inpatient_pharmacy_queue_action_bar_section.dart';

class InpatientPharmacyQueueScreen extends StatelessWidget {
  const InpatientPharmacyQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'inpatient_pharmacy_queue',
      title: 'Inpatient Pharmacy Queue',
      child: Column(
        children: const [
          const InpatientPharmacyQueueHeaderSection(),
          const InpatientPharmacyQueueContentSummarySection(),
          const InpatientPharmacyQueuePrimaryContentSection(),
          const InpatientPharmacyQueueActionBarSection(),
        ],
      ),
    );
  }
}
