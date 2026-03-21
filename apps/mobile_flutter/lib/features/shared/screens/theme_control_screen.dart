import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/theme/theme_provider.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ThemeControlScreen extends ConsumerWidget {
  const ThemeControlScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTheme = ref.watch(themeProvider);

    return PrimeCareScaffold(
      appBar: PrimeCareNavBar(
        title: const PrimeCareText(AppStrings.themeConfiguration),
      ),
      body: PrimeCareListView(
        padding: const EdgeInsets.all(24),
        children: [
          const PrimeCareText(AppStrings.selectThemeDesc),
          const PrimeCareSizedBox(height: 24),
          _buildThemeCard(
            context, ref, 
            AppStrings.lightThemeLabel, 
            PrimeCareThemeType.light, 
            activeTheme,
            Icons.light_mode,
          ),
          const PrimeCareSizedBox(height: 16),
          _buildThemeCard(
            context, ref, 
            AppStrings.darkThemeLabel, 
            PrimeCareThemeType.dark, 
            activeTheme,
            Icons.dark_mode,
          ),
          const PrimeCareSizedBox(height: 16),
          _buildThemeCard(
            context, ref, 
            AppStrings.highContrastLabel, 
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
        padding: const EdgeInsets.all(20),
        
        child: PrimeCareRow(
          children: [
            PrimeCareIcon(icon, color: isSelected ? Theme.of(context).colorScheme.secondary : Colors.grey),
            const PrimeCareSizedBox(width: 16),
            PrimeCareText(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            const Spacer(),
            if (isSelected) PrimeCareIcon(Icons.check_circle, color: Theme.of(context).colorScheme.secondary),
          ],
        ),
      ),
    );
  }
}
