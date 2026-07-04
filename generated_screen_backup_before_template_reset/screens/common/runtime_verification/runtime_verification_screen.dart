import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/runtime_verification_header_section.dart';
import 'sections/runtime_verification_content_summary_section.dart';
import 'sections/runtime_verification_primary_content_section.dart';
import 'sections/runtime_verification_action_bar_section.dart';

class RuntimeVerificationScreen extends StatelessWidget {
  const RuntimeVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'runtime_verification',
      title: 'RuntimeVerificationScreen',
      child: Column(
        children: const [
          const RuntimeVerificationHeaderSection(),
          const RuntimeVerificationContentSummarySection(),
          const RuntimeVerificationPrimaryContentSection(),
          const RuntimeVerificationActionBarSection(),
        ],
      ),
    );
  }
}
