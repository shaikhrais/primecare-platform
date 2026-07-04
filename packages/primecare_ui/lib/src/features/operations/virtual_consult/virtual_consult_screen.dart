import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/virtual_consult_header_section.dart';
import 'sections/virtual_consult_content_summary_section.dart';
import 'sections/virtual_consult_primary_content_section.dart';
import 'sections/virtual_consult_action_bar_section.dart';

class VirtualConsultScreen extends StatelessWidget {
  const VirtualConsultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'virtual_consult',
      title: 'Virtual Consult',
      child: Column(
        children: const [
          const VirtualConsultHeaderSection(),
          const VirtualConsultContentSummarySection(),
          const VirtualConsultPrimaryContentSection(),
          const VirtualConsultActionBarSection(),
        ],
      ),
    );
  }
}
