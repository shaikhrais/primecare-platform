import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/locale_provider.dart';

class LanguageToggleButton extends ConsumerWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final isEn = locale.languageCode == 'en';
    
    return IconButton(
      tooltip: isEn ? 'Passer en Français' : 'Switch to English',
      icon: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Icon(Icons.language, color: Colors.blueGrey.shade100),
          Positioned(
            bottom: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blueGrey.shade200, width: 1),
              ),
              child: Text(
                isEn ? 'EN' : 'FR',
                style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          )
        ],
      ),
      onPressed: () {
        final newLocale = isEn ? const Locale('fr') : const Locale('en');
        ref.read(localeProvider.notifier).setLocale(newLocale);
      },
    );
  }
}
