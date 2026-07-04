import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_feature_adoption_header_section.dart';
import 'sections/cto_feature_adoption_content_summary_section.dart';
import 'sections/cto_feature_adoption_primary_content_section.dart';
import 'sections/cto_feature_adoption_action_bar_section.dart';

class CtoFeatureAdoptionScreen extends StatelessWidget {
  const CtoFeatureAdoptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_feature_adoption',
      title: 'Cto Feature Adoption',
      child: Column(
        children: const [
          const CtoFeatureAdoptionHeaderSection(),
          const CtoFeatureAdoptionContentSummarySection(),
          const CtoFeatureAdoptionPrimaryContentSection(),
          const CtoFeatureAdoptionActionBarSection(),
        ],
      ),
    );
  }
}
