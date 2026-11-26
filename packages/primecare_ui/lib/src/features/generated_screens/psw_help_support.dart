// Existing Help entry. The registered API794 reader host is still unbound.
// Render an honest closed state; no legacy request, mutation or success scaffold.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

class PswHelpSupportScreen extends GovernedConsumerWidget {
  const PswHelpSupportScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    return PrimeWorkspaceScaffold(
      scaffoldKey: const Key('psw_help_support-screen'),
      backgroundColor: theme.colors.background,
      headerColor: theme.colors.surface,
      title: PrimeText('navigation.items.psw_help_support'.tr()),
      actions: const [],
      body: DashboardErrorWidget(message: 'workspace.no_data'.tr()),
    );
  }
}
