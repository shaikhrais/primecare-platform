import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/trial_data_collection_c_r_f_header_section.dart';
import 'sections/trial_data_collection_c_r_f_content_summary_section.dart';
import 'sections/trial_data_collection_c_r_f_primary_content_section.dart';
import 'sections/trial_data_collection_c_r_f_action_bar_section.dart';

class TrialDataCollectionCRFScreen extends StatelessWidget {
  const TrialDataCollectionCRFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'trial_data_collection_c_r_f',
      title: 'Trial Data Collection C R F',
      child: Column(
        children: const [
          const TrialDataCollectionCRFHeaderSection(),
          const TrialDataCollectionCRFContentSummarySection(),
          const TrialDataCollectionCRFPrimaryContentSection(),
          const TrialDataCollectionCRFActionBarSection(),
        ],
      ),
    );
  }
}
