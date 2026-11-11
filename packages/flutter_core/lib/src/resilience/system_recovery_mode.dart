// Governance - Category: service | Purpose: Layer: 05_USER_INTERFACE A reusable recovery screen for handling domain logistics failures. This widget provides a co...
// Layer: 05_USER_INTERFACE
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeText;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeIcon;
import 'package:flutter/material.dart';
import 'package:flutter_core/theme/theme_contrast.dart';

/// Shared inline connection recovery panel using the active semantic palette.
class SystemOfflinePanel extends StatelessWidget {
  final VoidCallback? onReset;
  const SystemOfflinePanel({super.key, this.onReset});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.error),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(children: [
          PrimeIcon(Icons.wifi_off_rounded, color: colors.onErrorContainer, size: 24),
          const SizedBox(width: 12),
          Expanded(child: PrimeText('System Unavailable',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colors.onErrorContainer, decoration: TextDecoration.none))),
        ]),
        const SizedBox(height: 8),
        PrimeText('Server is unreachable. Please check your connection.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onErrorContainer, decoration: TextDecoration.none)),
        if (onReset != null) ...[
          const SizedBox(height: 12),
          Align(alignment: Alignment.centerRight, child: TextButton.icon(
            onPressed: onReset,
            icon: const PrimeIcon(Icons.refresh, size: 16),
            label: const PrimeText('Retry'),
            style: TextButton.styleFrom(foregroundColor: colors.onErrorContainer),
          )),
        ],
      ]),
    );
  }
}

/// A reusable recovery screen for handling domain logistics failures.
/// This widget provides a consistent UI for error states across legacy and generated screens.
class SystemRecoveryMode extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;
  final VoidCallback onAttemptReset;

  const SystemRecoveryMode({
    super.key,
    required this.error,
    this.stackTrace,
    required this.onAttemptReset,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimeIcon(
                Icons.shield_outlined,
                color: colors.primary,
                size: 64,
              ),
              const SizedBox(height: 24),
              PrimeText(
                'System Recovery Mode',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              PrimeText(
                'A critical interface failure was intercepted. The session state has been protected and a diagnostic trail has been generated below.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 32),

              // FULL DIAGNOSTIC TRAIL
              _buildDiagnosticTrail(context),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onAttemptReset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                ),
                child: PrimeText(
                  'Attempt Interface Reset',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(color: colors.onPrimary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiagnosticTrail(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PrimeIcon(Icons.terminal_rounded, color: colors.primary, size: 18),
              SizedBox(width: 12),
              Expanded(child: PrimeText(
                'FULL DIAGNOSTIC TRAIL (SEND TO AGENT)',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: colors.outlineVariant, height: 1),
          ),
          PrimeText(
            'EXCEPTION:',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          SelectableText(
            error.toString(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: readableThemeForeground(colors.surfaceContainerHighest, colors.error),
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          PrimeText(
            'STACK TRACE:',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          SelectableText(
            stackTrace?.toString() ?? 'No stack trace captured.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontFamily: 'monospace',
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
