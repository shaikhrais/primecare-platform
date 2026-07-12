import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'responsive_preview_screen_controller.dart';
import 'sections/responsive_preview_header_section.dart';
import 'sections/responsive_preview_filter_bar_section.dart';
import 'sections/responsive_preview_data_table_section.dart';
import 'sections/responsive_preview_pagination_section.dart';
import 'sections/responsive_preview_action_bar_section.dart';


class ResponsivePreviewScreen extends ConsumerWidget {
  const ResponsivePreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(responsive_previewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ResponsivePreview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(responsive_previewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('responsive_preview_loading'), child: Semantics(label: 'responsive_preview_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('responsive_preview_screen'),
                    child: Column(
                      children: [
                        ResponsivePreviewHeaderSection(data: state.data),
                        ResponsivePreviewFilterBarSection(data: state.data),
                        ResponsivePreviewDataTableSection(data: state.data),
                        ResponsivePreviewPaginationSection(data: state.data),
                        ResponsivePreviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
