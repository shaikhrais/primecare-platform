import 'package:primecare_mobile/core/locale_provider.dart';
import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme_provider.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ThemeControlScreen extends ConsumerWidget {
  const ThemeControlScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTheme = ref.watch(themeProvider);

    return PrimeCareScaffold(
      
      body: PrimeCareListView(
        padding: EdgeInsets.all(24),
        children: [
          PrimeCareCard(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimeCareText('Language / Langue', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary)),
                  SizedBox(height: 16),
                  RadioListTile<Locale>(
                    title: PrimeCareText(AppLocalizations.of(context)!.englishEn),
                    value: Locale('en'),
                    groupValue: ref.watch(localeProvider),
                    onChanged: (val) {
                      if (val != null) ref.read(localeProvider.notifier).setLocale(val);
                    },
                  ),
                  RadioListTile<Locale>(
                    title: PrimeCareText(AppLocalizations.of(context)!.franAisFr),
                    value: Locale('fr'),
                    groupValue: ref.watch(localeProvider),
                    onChanged: (val) {
                      if (val != null) ref.read(localeProvider.notifier).setLocale(val);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          PrimeCareText(AppLocalizations.of(context)!.selectThemeDesc),
          SizedBox(height: 24),
          _buildThemeCard(
            context, ref, 
            AppLocalizations.of(context)!.lightThemeLabel, 
            PrimeCareThemeType.light, 
            activeTheme,
            Icons.light_mode,
          ),
          SizedBox(height: 16),
          _buildThemeCard(
            context, ref, 
            AppLocalizations.of(context)!.darkThemeLabel, 
            PrimeCareThemeType.dark, 
            activeTheme,
            Icons.dark_mode,
          ),
          SizedBox(height: 16),
          _buildThemeCard(
            context, ref, 
            AppLocalizations.of(context)!.highContrastLabel, 
            PrimeCareThemeType.highContrast, 
            activeTheme,
            Icons.contrast,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard(BuildContext context, WidgetRef ref, String title, PrimeCareThemeType type, PrimeCareThemeType active, IconData icon) {
    final isSelected = active == type;
    return InkWell(
      onTap: () => ref.read(themeProvider.notifier).setTheme(type),
      child: PrimeCareCard(
        padding: EdgeInsets.all(20),
        
        child: PrimeCareRow(
          children: [
            PrimeCareIcon(icon, color: isSelected ? Theme.of(context).colorScheme.secondary : Colors.grey),
            SizedBox(width: 16),
            PrimeCareText(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            Spacer(),
            if (isSelected) PrimeCareIcon(Icons.check_circle, color: Theme.of(context).colorScheme.secondary),
          ],
        ),
      ),
    );
  }
}
