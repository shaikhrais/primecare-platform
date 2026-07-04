import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/f_a_q_manager_header_section.dart';
import 'sections/f_a_q_manager_content_summary_section.dart';
import 'sections/f_a_q_manager_primary_content_section.dart';
import 'sections/f_a_q_manager_action_bar_section.dart';

class FAQManagerScreen extends StatelessWidget {
  const FAQManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'f_a_q_manager',
      title: 'F A Q Manager',
      child: Column(
        children: const [
          const FAQManagerHeaderSection(),
          const FAQManagerContentSummarySection(),
          const FAQManagerPrimaryContentSection(),
          const FAQManagerActionBarSection(),
        ],
      ),
    );
  }
}
