import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import '../../theme/theme_config_generated.dart';
import '../../theme/theme_settings_provider.dart';
import '../../src/localization/language_provider.dart';
import '../../providers/platform_providers.dart';

class ThemeSettingsDrawer extends ConsumerWidget {
  final String tenantDefaultPreset;

  const ThemeSettingsDrawer({
    super.key,
    required this.tenantDefaultPreset,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(themeSettingsProvider);
    final notifier = ref.read(themeSettingsProvider.notifier);

    // List of premium presets to showcase
    final presetsList = [
      'default',
      'defaultDark',
      'navyTealPalette',
      'emeraldGold',
      'charcoalTeal',
      'slateCrimson',
      'indigoCoral',
      'skyBlueOrange',
      'softGreenMaroon',
      'coolGreyPink',
      'light1',
      'light2',
      'light3',
      'dark1',
      'dark2',
      'dark3',
    ];

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(LucideIcons.settings, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Theme Settings',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(LucideIcons.x, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(),

            // Content Scroll
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Section: Layout Styles
                  Text(
                    'LAYOUT STYLE',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  _LayoutOptionCard(
                    title: 'Vertical Left',
                    subtitle: 'Sidebar on the left',
                    icon: LucideIcons.alignLeft,
                    isSelected: settings.layoutStyle == LayoutStyle.verticalLeft,
                    onTap: () => notifier.updateLayoutStyle(LayoutStyle.verticalLeft),
                  ),
                  _LayoutOptionCard(
                    title: 'Vertical Right',
                    subtitle: 'Sidebar on the right',
                    icon: LucideIcons.alignRight,
                    isSelected: settings.layoutStyle == LayoutStyle.verticalRight,
                    onTap: () => notifier.updateLayoutStyle(LayoutStyle.verticalRight),
                  ),
                  _LayoutOptionCard(
                    title: 'Horizontal Navigation',
                    subtitle: 'Navbar on the top',
                    icon: LucideIcons.menu,
                    isSelected: settings.layoutStyle == LayoutStyle.horizontal,
                    onTap: () => notifier.updateLayoutStyle(LayoutStyle.horizontal),
                  ),
                  _LayoutOptionCard(
                    title: 'Collapsed Navigation',
                    subtitle: 'Mini sidebar icons',
                    icon: LucideIcons.columns,
                    isSelected: settings.layoutStyle == LayoutStyle.collapsed,
                    onTap: () => notifier.updateLayoutStyle(LayoutStyle.collapsed),
                  ),
                  const SizedBox(height: 24),

                  // Section: Preset Colors
                  Text(
                    'THEME PRESETS',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: presetsList.length,
                    itemBuilder: (context, index) {
                      final name = presetsList[index];
                      final palette = ThemeConfig.getAppPalette(name);
                      final isSelected = settings.presetName == name;

                      return Tooltip(
                        message: name,
                        child: InkWell(
                          onTap: () => notifier.updatePreset(name),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: palette.primary,
                              border: Border.all(
                                color: isSelected
                                    ? (palette.brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black87)
                                    : Colors.transparent,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: palette.primary.withValues(alpha: 0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: isSelected
                                ? Icon(
                                    LucideIcons.check,
                                    size: 16,
                                    color: palette.onPrimary,
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Section: Options & Switches
                  Text(
                    'APPLICATION LANGUAGE',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  ...() {
                    String activeLang = ref.watch(languageProvider);
                    List<String> supportedLanguages = const ['en', 'fr', 'es'];
                    try {
                      final app = ref.watch(platformApplicationProvider);
                      final themeKey = app.appId.replaceAll('primecare_', '');
                      final palette = ThemeConfig.getAppPalette(themeKey);
                      supportedLanguages = palette.supportedLanguages;
                    } catch (_) {}

                    return supportedLanguages.map((lang) {
                      String title = '';
                      String flag = '';
                      if (lang == 'en') {
                        title = 'English (EN)';
                        flag = '🇺🇸';
                      } else if (lang == 'fr') {
                        title = 'Français (FR)';
                        flag = '🇫🇷';
                      } else if (lang == 'es') {
                        title = 'Español (ES)';
                        flag = '🇪🇸';
                      } else if (lang == 'ar') {
                        title = 'العربية (AR)';
                        flag = '🇸🇦';
                      } else {
                        title = lang.toUpperCase();
                        flag = '🌐';
                      }
                      final isSelected = activeLang == lang;

                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade200,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (context.mounted) {
                              await context.setLocale(Locale(lang));
                            }
                            await ref.read(languageProvider.notifier).setLanguage(lang);
                            
                            // Automatically adjust RTL layout direction for Arabic
                            if (lang == 'ar') {
                              notifier.updateDirection(TextDirection.rtl);
                            } else {
                              notifier.updateDirection(TextDirection.ltr);
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Text(flag, style: const TextStyle(fontSize: 20)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    title,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                          color: isSelected ? Theme.of(context).primaryColor : null,
                                        ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    LucideIcons.checkCircle,
                                    color: Theme.of(context).primaryColor,
                                    size: 18,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  }(),
                  const SizedBox(height: 24),

                  Text(
                    'ADDITIONAL OPTIONS',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 12),

                  // Text Direction (RTL / LTR)
                  SwitchListTile(
                    title: const Text('RTL Direction'),
                    subtitle: const Text('Flip elements layout direction'),
                    value: settings.direction == TextDirection.rtl,
                    onChanged: (val) {
                      notifier.updateDirection(
                          val ? TextDirection.rtl : TextDirection.ltr);
                    },
                    secondary: const Icon(LucideIcons.alignRight),
                  ),

                  // Custom Scrollbars
                  SwitchListTile(
                    title: const Text('Custom Scrollbars'),
                    subtitle: const Text('Use clean styled scroll bars'),
                    value: settings.customScrollbars,
                    onChanged: (val) {
                      notifier.toggleScrollbars(val);
                    },
                    secondary: const Icon(LucideIcons.mousePointer),
                  ),
                ],
              ),
            ),
            const Divider(),

            // Drawer Footer (Reset)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        notifier.resetToTenantDefault(tenantDefaultPreset);
                      },
                      child: const Text('Reset to Defaults'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LayoutOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _LayoutOptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? theme.primaryColor : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.primaryColor.withValues(alpha: 0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? theme.primaryColor : Colors.grey.shade600,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? theme.primaryColor : null,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.grey.shade500,
                          ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  LucideIcons.checkCircle,
                  color: theme.primaryColor,
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
