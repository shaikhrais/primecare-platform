import 'package:primecare_ui/primecare_ui.dart';
import 'auth_experience.dart' show PrimeAuthTextField;
import 'auth_lifecycle_catalog.g.dart';
import 'mfa_management_controller.dart';

Map<String, String> mfaLifecycleLabels(BuildContext context) =>
  authLifecycleText[Localizations.localeOf(context).languageCode] ?? authLifecycleText['en']!;

/// Readonly accessible proof text remains transient and is never logged/stored.
class MfaReplacementKey extends StatelessWidget {
  final String setupKey;
  const MfaReplacementKey({super.key, required this.setupKey});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme, text = mfaLifecycleLabels(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(text['newKey']!, style: theme.typography.bodyMedium), SizedBox(height: theme.spacing.md),
      Cy(id: 'mfa-lifecycle-newkey', child: Semantics(container: true, label: setupKey,
        excludeSemantics: true, child: SelectableText(setupKey, style: theme.typography.bodyMedium))),
    ]);
  }
}

class NativeMfaManagementForm extends ConsumerWidget {
  const NativeMfaManagementForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mfaManagementProvider), controller = ref.read(mfaManagementProvider.notifier);
    final text = mfaLifecycleLabels(context), theme = context.theme;
    final gap = SizedBox(height: theme.spacing.lg);
    final children = <Widget>[];
    if (!state.canManage) {
      return Cy(id: 'mfa-lifecycle-error', child: Semantics(liveRegion: true,
        child: Text(text['error']!, style: theme.typography.bodyMedium)));
    }
    children.add(Cy(id: 'mfa-lifecycle-title', child: Semantics(header: true, child: Text(text['title']!, style: theme.typography.h2))));
    children.add(gap);
    if (state.recoveryCodes.isNotEmpty) {
      children.addAll([
        Text(text['codes']!, style: theme.typography.bodyMedium), gap,
        Cy(id: 'mfa-lifecycle-codes', child: Semantics(container: true, label: state.recoveryCodes.join('\n'),
          excludeSemantics: true,
          child: SelectableText(state.recoveryCodes.join('\n'), style: theme.typography.bodyMedium))), gap,
        PrimeButton(label: text['saved']!, onPressed: controller.saved, isFullWidth: true, dataCy: 'mfa-lifecycle-saved'),
      ]);
    } else if (state.replacement != null) {
      children.addAll([
        MfaReplacementKey(setupKey: state.replacement!['setupKey'] as String), gap,
        PrimeAuthTextField(id: 'mfa-lifecycle-newcode', label: text['newCode']!,
          initialValue: state.newCode, onChanged: controller.onNewCodeChanged, sensitive: true,
          enabled: !state.working, keyboardType: TextInputType.number, autofocus: true,
          autofillHints: const [AutofillHints.oneTimeCode], onSubmitted: (_) => controller.confirm()), gap,
        PrimeButton(label: text[state.working ? 'working' : 'confirm']!, onPressed: controller.confirm,
          isLoading: state.working, isFullWidth: true, dataCy: 'mfa-lifecycle-confirm'), gap,
        PrimeButton(label: text['cancel']!, onPressed: state.working ? null : controller.cancel,
          isFullWidth: true, dataCy: 'mfa-lifecycle-cancel'),
      ]);
    } else if (state.finished) {
      children.add(Cy(id: 'mfa-lifecycle-done', child: Semantics(liveRegion: true,
        child: Text(text['done']!, style: theme.typography.bodyMedium))));
    } else {
      children.addAll([
        PrimeAuthTextField(id: 'mfa-lifecycle-password', label: text['password']!,
          initialValue: state.password, onChanged: controller.onPasswordChanged, password: true,
          enabled: !state.working, autofillHints: const [AutofillHints.password]), gap,
        PrimeAuthTextField(id: 'mfa-lifecycle-factor', label: text['factor']!,
          initialValue: state.factor, onChanged: controller.onFactorChanged, sensitive: true,
          enabled: !state.working, keyboardType: TextInputType.number,
          autofillHints: const [AutofillHints.oneTimeCode]), gap,
        PrimeButton(label: text[state.working ? 'working' : 'issue']!, onPressed: controller.issueCodes,
          isLoading: state.working, isFullWidth: true, dataCy: 'mfa-lifecycle-issue'), gap,
        PrimeButton(label: text['replace']!, onPressed: state.working ? null : controller.replace,
          isFullWidth: true, dataCy: 'mfa-lifecycle-replace'),
      ]);
    }
    if (state.working) children.addAll([gap, Cy(id: 'mfa-lifecycle-working', child: Semantics(liveRegion: true,
      child: Text(text['working']!, style: theme.typography.bodyMedium)))]);
    if (state.failed) children.addAll([gap, Cy(id: 'mfa-lifecycle-error', child: Semantics(liveRegion: true,
      child: Text(text['error']!, style: theme.typography.bodyMedium)))]);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
  }
}
