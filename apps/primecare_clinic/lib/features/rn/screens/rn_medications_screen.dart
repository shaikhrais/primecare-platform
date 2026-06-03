import 'package:primecare_ui/primecare_ui.dart';

class RnMedicationsScreen extends ConsumerWidget {
  const RnMedicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final title = 'MedicationScreen';

    return Cy(
      id: 'rnmedications-screen medication-screen',
      child: Scaffold(
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(label: 'data-cy:rnmedications-title', container: true, child: Container(child:  Text(
            key: const Key('rnmedications-title medication-title'),
            title,
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ))),
        ),
        body: Semantics(
          label: 'data-cy:rnmedications-content',
          container: true,
          child: Cy(
          id: 'rnmedications-content medication-content',
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
                      Text(
                        title,
                        style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
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
