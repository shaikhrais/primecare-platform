import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/course_architect_compliance_header_section.dart';
import 'sections/course_architect_compliance_filter_bar_section.dart';
import 'sections/course_architect_compliance_data_table_section.dart';
import 'sections/course_architect_compliance_pagination_section.dart';
import 'sections/course_architect_compliance_action_bar_section.dart';

class CourseArchitectComplianceScreen extends StatelessWidget {
  const CourseArchitectComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'course_architect_compliance',
      title: 'CourseArchitectComplianceScreen',
      child: Column(
        children: const [
          const CourseArchitectComplianceHeaderSection(),
          const CourseArchitectComplianceFilterBarSection(),
          const CourseArchitectComplianceDataTableSection(),
          const CourseArchitectCompliancePaginationSection(),
          const CourseArchitectComplianceActionBarSection(),
        ],
      ),
    );
  }
}
