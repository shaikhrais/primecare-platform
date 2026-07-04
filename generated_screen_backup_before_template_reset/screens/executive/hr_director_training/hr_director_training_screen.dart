import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_director_training_header_section.dart';
import 'sections/hr_director_training_content_summary_section.dart';
import 'sections/hr_director_training_primary_content_section.dart';
import 'sections/hr_director_training_action_bar_section.dart';

class HrDirectorTrainingScreen extends StatelessWidget {
  const HrDirectorTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_director_training',
      title: 'HrDirectorTrainingScreen',
      child: Column(
        children: const [
          const HrDirectorTrainingHeaderSection(),
          const HrDirectorTrainingContentSummarySection(),
          const HrDirectorTrainingPrimaryContentSection(),
          const HrDirectorTrainingActionBarSection(),
        ],
      ),
    );
  }
}
