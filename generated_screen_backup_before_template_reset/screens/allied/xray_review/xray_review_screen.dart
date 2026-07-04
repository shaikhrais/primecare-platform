import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/xray_review_header_section.dart';
import 'sections/xray_review_filter_bar_section.dart';
import 'sections/xray_review_data_table_section.dart';
import 'sections/xray_review_pagination_section.dart';
import 'sections/xray_review_action_bar_section.dart';

class XrayReviewScreen extends StatelessWidget {
  const XrayReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'xray_review',
      title: 'XrayReviewScreen',
      child: Column(
        children: const [
          const XrayReviewHeaderSection(),
          const XrayReviewFilterBarSection(),
          const XrayReviewDataTableSection(),
          const XrayReviewPaginationSection(),
          const XrayReviewActionBarSection(),
        ],
      ),
    );
  }
}
