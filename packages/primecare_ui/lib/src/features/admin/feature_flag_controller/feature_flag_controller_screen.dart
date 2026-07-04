import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/feature_flag_controller_header_section.dart';
import 'sections/feature_flag_controller_content_summary_section.dart';
import 'sections/feature_flag_controller_primary_content_section.dart';
import 'sections/feature_flag_controller_action_bar_section.dart';

class FeatureFlagControllerScreen extends StatelessWidget {
  const FeatureFlagControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'feature_flag_controller',
      title: 'Feature Flag Controller',
      child: Column(
        children: const [
          const FeatureFlagControllerHeaderSection(),
          const FeatureFlagControllerContentSummarySection(),
          const FeatureFlagControllerPrimaryContentSection(),
          const FeatureFlagControllerActionBarSection(),
        ],
      ),
    );
  }
}
