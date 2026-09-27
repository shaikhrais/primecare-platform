import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sso_redirect_screen_controller.dart';
import 'sections/sso_redirect_header_section.dart';
import 'sections/sso_redirect_content_summary_section.dart';
import 'sections/sso_redirect_primary_content_section.dart';
import 'sections/sso_redirect_action_bar_section.dart';


class SsoRedirectScreen extends ConsumerWidget {
  const SsoRedirectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sso_redirectControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Sso Redirect'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(sso_redirectControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('sso_redirect_loading'), child: Semantics(label: 'sso_redirect_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('sso_redirect_screen'),
                    child: Column(
                      children: [
                        SsoRedirectHeaderSection(data: state.data),
                        SsoRedirectContentSummarySection(data: state.data),
                        SsoRedirectPrimaryContentSection(data: state.data),
                        SsoRedirectActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
