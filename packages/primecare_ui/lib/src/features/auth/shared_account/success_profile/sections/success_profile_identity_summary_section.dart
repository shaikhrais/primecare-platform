import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SuccessProfileIdentitySummarySection extends ConsumerWidget {
  const SuccessProfileIdentitySummarySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = context.theme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
                child: Text(
                  (authState.userName ?? 'U')[0].toUpperCase(),
                  style: TextStyle(
                    color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                authState.userName ?? 'auth_success_default_user'.tr(),
                style: theme.typography.bodyMedium.copyWith(
                  color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent),
                ),
                child: Text(
                  (authState.role ?? 'Guest').toUpperCase(),
                  style: theme.typography.labelSmall.copyWith(
                    color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          tooltip: 'auth_success_sign_out'.tr(),
          icon: Icon(LucideIcons.logOut, color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent),
          onPressed: () async {
            await ref.read(authProvider.notifier).logout();
          },
        ),
      ],
    );
  }
}
