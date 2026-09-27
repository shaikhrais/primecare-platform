import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/api_key_manager_header_section.dart';
import 'sections/api_key_manager_content_summary_section.dart';
import 'sections/api_key_manager_primary_content_section.dart';
import 'sections/api_key_manager_action_bar_section.dart';

class ApiKeyManagerScreen extends StatelessWidget {
  const ApiKeyManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'api_key_manager',
      title: 'Api Key Manager',
      child: Column(
        children: const [
          const ApiKeyManagerHeaderSection(),
          const ApiKeyManagerContentSummarySection(),
          const ApiKeyManagerPrimaryContentSection(),
          const ApiKeyManagerActionBarSection(),
        ],
      ),
    );
  }
}
