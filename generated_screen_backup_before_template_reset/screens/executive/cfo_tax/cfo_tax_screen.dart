import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_tax_header_section.dart';
import 'sections/cfo_tax_content_summary_section.dart';
import 'sections/cfo_tax_primary_content_section.dart';
import 'sections/cfo_tax_action_bar_section.dart';

class CfoTaxScreen extends StatelessWidget {
  const CfoTaxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_tax',
      title: 'CfoTaxScreen',
      child: Column(
        children: const [
          const CfoTaxHeaderSection(),
          const CfoTaxContentSummarySection(),
          const CfoTaxPrimaryContentSection(),
          const CfoTaxActionBarSection(),
        ],
      ),
    );
  }
}
