import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswShiftTrackerScreen extends ConsumerWidget {
  const PswShiftTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final title = 'PswShiftTrackerScreen';

    return Cy(
      id: 'pswshifttracker-screen',
      child: Scaffold(
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          title: Cy(
            id: 'pswshifttracker-title',
            child: const Text('PswShiftTracker'),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswshifttracker-content',
          container: true,
          child: Cy(
            id: 'pswshifttracker-content',
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Cy(
                          id: 'pswshifttracker-title',
                          child: Semantics(
                            label: 'data-cy:pswshifttracker-title',
                            container: true,
                            button: true,
                            enabled: true,
                            onTap: () {},
                            child: Text(
                              title,
                              style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Governed operational interface to monitor patient parameters, review compliance posture, and maintain Zero-Trust synchronization.',
                          style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
