import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'runtime_verification_screen_controller.dart';
import 'sections/runtime_verification_header_section.dart';
import 'sections/runtime_verification_content_summary_section.dart';
import 'sections/runtime_verification_primary_content_section.dart';
import 'sections/runtime_verification_action_bar_section.dart';


class RuntimeVerificationScreen extends ConsumerWidget {
  const RuntimeVerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(runtime_verificationControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RuntimeVerification'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(runtime_verificationControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('runtime_verification_loading'), child: Semantics(label: 'runtime_verification_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('runtime_verification_screen'),
                    child: Column(
                      children: [
                        RuntimeVerificationHeaderSection(data: state.data),
                        RuntimeVerificationContentSummarySection(data: state.data),
                        RuntimeVerificationPrimaryContentSection(data: state.data),
                        RuntimeVerificationActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
