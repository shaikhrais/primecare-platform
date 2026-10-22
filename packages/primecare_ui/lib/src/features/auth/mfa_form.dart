import 'package:primecare_ui/primecare_ui.dart';
import 'auth_experience.dart' show PrimeAuthTextField;
import 'mfa_catalog.g.dart';
import 'mfa_management_form.dart';

/// Presentation of existing screen949 controls; verification lives in flutter_core.
class NativeMfaForm extends ConsumerWidget {
  const NativeMfaForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mfaControllerProvider);
    final controller = ref.read(mfaControllerProvider.notifier);
    final text = nativeMfaText[Localizations.localeOf(context).languageCode] ?? nativeMfaText['en']!;
    final lifecycle = mfaLifecycleLabels(context);
    final theme = context.theme;
    if (!state.pending) return const SizedBox.shrink();
    return Cy(id: 'mfa-form', child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Semantics(header: true, child: Text(text['title']!, style: theme.typography.h2)),
      if (state.challenge!['purpose'] == 'enroll') ...[
        SizedBox(height: theme.spacing.md), Text(text['setup']!, style: theme.typography.bodyMedium),
        SizedBox(height: theme.spacing.md),
        Cy(id: 'mfa-seed', child: Semantics(
          container: true, label: state.challenge!['setupKey'] as String,
          excludeSemantics: true,
          child: SelectableText(state.challenge!['setupKey'] as String, style: theme.typography.bodyMedium))),
      ],
      if (state.challenge!['purpose'] == 'replace') ...[
        SizedBox(height: theme.spacing.md), MfaReplacementKey(setupKey: state.challenge!['setupKey'] as String),
      ],
      SizedBox(height: theme.spacing.lg),
      if (state.recoveryMode) ...[
        PrimeAuthTextField(id: 'mfa-lifecycle-recoverycode', label: lifecycle['recoveryCode']!,
          initialValue: state.recoveryCode, enabled: !state.isLoading, sensitive: true, autofocus: true,
          onChanged: controller.onRecoveryCodeChanged, onSubmitted: (_) => controller.recover()),
        SizedBox(height: theme.spacing.lg),
        PrimeButton(label: lifecycle[state.isLoading ? 'working' : 'recover']!, onPressed: controller.recover,
          isLoading: state.isLoading, isFullWidth: true, dataCy: 'mfa-lifecycle-recover'),
        SizedBox(height: theme.spacing.md),
        PrimeButton(label: lifecycle['cancel']!, onPressed: state.isLoading ? null : controller.showAuthenticator,
          isFullWidth: true, dataCy: 'mfa-lifecycle-cancel'),
      ] else ...[
      PrimeAuthTextField(id: state.challenge!['purpose'] == 'replace' ? 'mfa-lifecycle-newcode' : 'mfa-code',
        label: state.challenge!['purpose'] == 'replace' ? lifecycle['newCode']! : text['code']!, initialValue: state.code,
        enabled: !state.isLoading, sensitive: true, autofocus: true, keyboardType: TextInputType.number,
        autofillHints: const [AutofillHints.oneTimeCode],
        onChanged: controller.onCodeChanged, onSubmitted: (_) => controller.verify()),
      SizedBox(height: theme.spacing.lg),
      PrimeButton(label: state.challenge!['purpose'] == 'replace' ? lifecycle[state.isLoading ? 'working' : 'confirm']! : text[state.isLoading ? 'loading' : 'submit']!, onPressed: controller.verify,
        isLoading: state.isLoading, isFullWidth: true, dataCy: state.challenge!['purpose'] == 'replace' ? 'mfa-lifecycle-confirm' : 'mfa-submit'),
      if (state.recoveryAvailable) ...[SizedBox(height: theme.spacing.md),
        PrimeButton(label: lifecycle['recovery']!, onPressed: state.isLoading ? null : controller.showRecovery,
          isFullWidth: true, dataCy: 'mfa-lifecycle-recovery')],
      ],
      if (state.failed) ...[SizedBox(height: theme.spacing.md),
        Cy(id: 'mfa-status', child: Semantics(liveRegion: true, child: Text(state.recoveryMode || state.challenge!['purpose'] == 'replace' ? lifecycle['error']! : text['error']!, style: theme.typography.bodyMedium)))],
      SizedBox(height: theme.spacing.md),
      PrimeButton(label: text['cancel']!, onPressed: state.isLoading ? null : controller.cancel,
        isFullWidth: true, dataCy: 'mfa-cancel'),
    ]));
  }
}
