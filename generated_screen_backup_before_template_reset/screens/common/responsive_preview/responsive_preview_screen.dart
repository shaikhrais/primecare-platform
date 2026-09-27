import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/responsive_preview_header_section.dart';
import 'sections/responsive_preview_filter_bar_section.dart';
import 'sections/responsive_preview_data_table_section.dart';
import 'sections/responsive_preview_pagination_section.dart';
import 'sections/responsive_preview_action_bar_section.dart';

class ResponsivePreviewScreen extends StatelessWidget {
  const ResponsivePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'responsive_preview',
      title: 'ResponsivePreviewScreen',
      child: Column(
        children: const [
          const ResponsivePreviewHeaderSection(),
          const ResponsivePreviewFilterBarSection(),
          const ResponsivePreviewDataTableSection(),
          const ResponsivePreviewPaginationSection(),
          const ResponsivePreviewActionBarSection(),
        ],
      ),
    );
  }
}
