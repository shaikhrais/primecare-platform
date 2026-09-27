import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'service_quality_screen_controller.dart';
import 'sections/service_quality_header_section.dart';
import 'sections/service_quality_content_summary_section.dart';
import 'sections/service_quality_primary_content_section.dart';
import 'sections/service_quality_action_bar_section.dart';


class ServiceQualityScreen extends ConsumerWidget {
  const ServiceQualityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(service_qualityControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ServiceQuality'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(service_qualityControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('service_quality_loading'), child: Semantics(label: 'service_quality_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('service_quality_screen'),
                    child: Column(
                      children: [
                        ServiceQualityHeaderSection(data: state.data),
                        ServiceQualityContentSummarySection(data: state.data),
                        ServiceQualityPrimaryContentSection(data: state.data),
                        ServiceQualityActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
