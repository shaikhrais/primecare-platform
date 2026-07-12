import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'xray_review_screen_controller.dart';
import 'sections/xray_review_header_section.dart';
import 'sections/xray_review_filter_bar_section.dart';
import 'sections/xray_review_data_table_section.dart';
import 'sections/xray_review_pagination_section.dart';
import 'sections/xray_review_action_bar_section.dart';


class XrayReviewScreen extends ConsumerWidget {
  const XrayReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(xray_reviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('XrayReview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(xray_reviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('xray_review_loading'), child: Semantics(label: 'xray_review_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('xray_review_screen'),
                    child: Column(
                      children: [
                        XrayReviewHeaderSection(data: state.data),
                        XrayReviewFilterBarSection(data: state.data),
                        XrayReviewDataTableSection(data: state.data),
                        XrayReviewPaginationSection(data: state.data),
                        XrayReviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
