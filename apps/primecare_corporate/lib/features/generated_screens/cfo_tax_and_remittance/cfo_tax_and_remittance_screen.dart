import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_tax_and_remittance_header_section.dart';
import 'sections/cfo_tax_and_remittance_content_summary_section.dart';
import 'sections/cfo_tax_and_remittance_primary_content_section.dart';
import 'sections/cfo_tax_and_remittance_action_bar_section.dart';

class CfoTaxAndRemittanceScreen extends StatelessWidget {
  const CfoTaxAndRemittanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_tax_and_remittance',
      title: 'Cfo Tax And Remittance',
      child: Column(
        children: const [
          const CfoTaxAndRemittanceHeaderSection(),
          const CfoTaxAndRemittanceContentSummarySection(),
          const CfoTaxAndRemittancePrimaryContentSection(),
          const CfoTaxAndRemittanceActionBarSection(),
        ],
      ),
    );
  }
}
