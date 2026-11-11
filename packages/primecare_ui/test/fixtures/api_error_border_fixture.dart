import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ApiErrorBorderFixture extends ConsumerWidget {
  final VoidCallback onRetry;
  const ApiErrorBorderFixture({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context, WidgetRef ref) => buildScreen(context, ref);

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    return Cy(id: 'api-error', child: Container(
      key: const Key('error-panel'),
      decoration: BoxDecoration(border: Border.all(color: theme.colors.error)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const PrimeStatusText('Could not load care details', tone: PrimeStatusTone.error),
        PrimeButton(label: 'Retry', onPressed: onRetry),
      ]),
    ));
  }
}
