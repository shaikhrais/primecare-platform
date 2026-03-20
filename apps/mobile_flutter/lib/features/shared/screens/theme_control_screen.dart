import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/theme/theme_provider.dart';

class ThemeControlScreen extends ConsumerWidget {
  const ThemeControlScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTheme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.themeConfiguration),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(AppStrings.selectThemeDesc),
          const SizedBox(height: 24),
          _buildThemeCard(
            context, ref, 
            AppStrings.lightThemeLabel, 
            PrimeCareThemeType.light, 
            activeTheme,
            Icons.light_mode,
          ),
          const SizedBox(height: 16),
          _buildThemeCard(
            context, ref, 
            AppStrings.darkThemeLabel, 
            PrimeCareThemeType.dark, 
            activeTheme,
            Icons.dark_mode,
          ),
          const SizedBox(height: 16),
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
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Theme.of(context).colorScheme.secondary : Colors.grey.withAlpha(50), width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Theme.of(context).colorScheme.secondary : Colors.grey),
            const SizedBox(width: 16),
            Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            const Spacer(),
            if (isSelected) Icon(Icons.check_circle, color: Theme.of(context).colorScheme.secondary),
          ],
        ),
      ),
    );
  }
}
