import 'package:primecare_ui/primecare_ui.dart';
import 'auth_experience.dart' show PrimeAuthTextField;
import 'mfa_catalog.g.dart';

/// Presentation of existing screen949 controls; verification lives in flutter_core.
class NativeMfaForm extends ConsumerWidget {
  const NativeMfaForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mfaControllerProvider);
    final controller = ref.read(mfaControllerProvider.notifier);
    final text = nativeMfaText[Localizations.localeOf(context).languageCode] ?? nativeMfaText['en']!;
    final theme = context.theme;
    if (!state.pending) return const SizedBox.shrink();
    return Cy(id: 'mfa-form', child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Semantics(header: true, child: Text(text['title']!, style: theme.typography.h2)),
      if (state.challenge!['purpose'] == 'enroll') ...[
        SizedBox(height: theme.spacing.md), Text(text['setup']!, style: theme.typography.bodyMedium),
        SizedBox(height: theme.spacing.md),
        Cy(id: 'mfa-seed', child: Semantics(
          label: state.challenge!['setupKey'] as String,
          excludeSemantics: true,
          child: SelectableText(state.challenge!['setupKey'] as String, style: theme.typography.bodyMedium))),
      ],
      SizedBox(height: theme.spacing.lg),
      PrimeAuthTextField(id: 'mfa-code', label: text['code']!, initialValue: state.code,
        enabled: !state.isLoading, sensitive: true, autofocus: true, keyboardType: TextInputType.number,
        autofillHints: const [AutofillHints.oneTimeCode],
        onChanged: controller.onCodeChanged, onSubmitted: (_) => controller.verify()),
      if (state.failed) ...[SizedBox(height: theme.spacing.md),
        Cy(id: 'mfa-status', child: Semantics(liveRegion: true, child: Text(text['error']!, style: theme.typography.bodyMedium)))],
      SizedBox(height: theme.spacing.lg),
      PrimeButton(label: text[state.isLoading ? 'loading' : 'submit']!, onPressed: controller.verify,
        isLoading: state.isLoading, isFullWidth: true, dataCy: 'mfa-submit'),
      SizedBox(height: theme.spacing.md),
      PrimeButton(label: text['cancel']!, onPressed: state.isLoading ? null : controller.cancel,
        isFullWidth: true, dataCy: 'mfa-cancel'),
    ]));
  }
}
