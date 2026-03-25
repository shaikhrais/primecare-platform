import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../locale_provider.dart';

class LanguageToggleButton extends ConsumerWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final isFrench = currentLocale.languageCode == 'fr';

    return IconButton(
      tooltip: isFrench ? 'Passer en Anglais' : 'Switch to French',
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.primary.withAlpha(isFrench ? 50 : 20),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withAlpha(100),
          ),
        ),
        child: Text(
          isFrench ? 'FR' : 'EN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      onPressed: () {
        ref
            .read(localeProvider.notifier)
            .setLocale(Locale(isFrench ? 'en' : 'fr'));
      },
    );
  }
}
