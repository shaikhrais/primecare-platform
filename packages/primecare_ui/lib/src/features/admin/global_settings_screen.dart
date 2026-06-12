// Governance - Category: view | Purpose: UI Screen component rendering the Centralized Theme & Branding Settings workspace interface.
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class GlobalSettingsScreen extends GovernedConsumerStatefulWidget {
  @override
  String get screenDescription =>
      'The screen requires components for color customization, theme selection, and notifications, along with functions for validation and API interaction.';

  @override
  List<String> get requiredComponents => const [
        'ColorPicker',
        'ThemeSelector',
        'NotificationBanner',
        'LoadingIndicator',
        'ThemePreview',
      ];

  @override
  List<String> get requiredFunctions => const [
        'validateForm',
        'saveSettings',
        'showSuccessMessage',
        'showErrorMessage',
        'previewTheme',
      ];

  const GlobalSettingsScreen({super.key});

  @override
  ConsumerState<GlobalSettingsScreen> createState() => _GlobalSettingsScreenState();
}

class _GlobalSettingsScreenState extends GovernedConsumerState<GlobalSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _primaryController = TextEditingController();
  final _primaryContainerController = TextEditingController();
  final _sidebarBgController = TextEditingController();
  final _topbarBgController = TextEditingController();

  bool _isSaving = false;

  final List<String> _presets = [
    'default',
    'defaultDark',
    'navyTealPalette',
    'indigoAmberPalette',
    'darkBlueSilver',
    'slateCrimson',
    'emeraldGold',
    'indigoCoral',
    'charcoalTeal',
    'skyBlueOrange',
    'softGreenMaroon',
    'coolGreyPink',
    'light1',
    'light2',
    'light3',
    'dark1',
    'dark2',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settings = ref.read(themeSettingsProvider);
      _primaryController.text = settings.customPrimary ?? '';
      _primaryContainerController.text = settings.customPrimaryContainer ?? '';
      _sidebarBgController.text = settings.customSidebarBg ?? '';
      _topbarBgController.text = settings.customTopbarBg ?? '';
    });
  }

  @override
  void dispose() {
    _primaryController.dispose();
    _primaryContainerController.dispose();
    _sidebarBgController.dispose();
    _topbarBgController.dispose();
    super.dispose();
  }

  Color? _parseColor(String hexStr) {
    final clean = hexStr.replaceAll('#', '').trim();
    if (clean.length == 6) {
      return Color(int.parse('0xFF$clean'));
    } else if (clean.length == 8) {
      return Color(int.parse('0x$clean'));
    }
    return null;
  }

  Future<void> _saveSettings() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSaving = true;
      });

      final settings = ref.read(themeSettingsProvider);
      final notifier = ref.read(themeSettingsProvider.notifier);
      final api = ref.read(apiClientProvider);

      final payload = {
        'presetName': settings.presetName,
        'layoutStyle': settings.layoutStyle.name,
        'direction': settings.direction.name,
        'customScrollbars': settings.customScrollbars,
        'branding': {
          'primary': _primaryController.text.trim().isNotEmpty ? _primaryController.text.trim() : null,
          'primaryContainer': _primaryContainerController.text.trim().isNotEmpty ? _primaryContainerController.text.trim() : null,
          'sidebarBackground': _sidebarBgController.text.trim().isNotEmpty ? _sidebarBgController.text.trim() : null,
          'topbarBackground': _topbarBgController.text.trim().isNotEmpty ? _topbarBgController.text.trim() : null,
        }
      };

      try {
        // Call the mock branding API
        await api.post('/v1/admin/settings/branding', body: payload);

        // Update local Riverpod custom colors
        await notifier.updateCustomColors(
          primary: _primaryController.text.trim().isNotEmpty ? _primaryController.text.trim() : null,
          primaryContainer: _primaryContainerController.text.trim().isNotEmpty ? _primaryContainerController.text.trim() : null,
          sidebarBg: _sidebarBgController.text.trim().isNotEmpty ? _sidebarBgController.text.trim() : null,
          topbarBg: _topbarBgController.text.trim().isNotEmpty ? _topbarBgController.text.trim() : null,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12),
                  Text('Branding and Settings saved successfully!'),
                ],
              ),
              backgroundColor: Colors.green.shade700,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to save configurations: $e'),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSaving = false;
          });
        }
      }
    }
  }

  @override
  Widget buildScreen(BuildContext context) {
    final theme = context.theme;
    final settings = ref.watch(themeSettingsProvider);
    final notifier = ref.read(themeSettingsProvider.notifier);

    // Live previews of resolved colors
    final activePalette = ThemeConfig.getAppPalette(settings.presetName);
    final currentPrimary = _parseColor(_primaryController.text) ?? activePalette.primary;
    final currentPrimaryContainer = _parseColor(_primaryContainerController.text) ?? activePalette.primaryContainer;
    final currentSidebarBg = _parseColor(_sidebarBgController.text) ?? activePalette.sidebarBackground;
    final currentTopbarBg = _parseColor(_topbarBgController.text) ?? activePalette.topbarBackground;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'Institutional Branding Center',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left configuration form (Scrollable)
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tenant Settings & Styling',
                      style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Customize colors, themes, structural layouts, and language settings for this tenant.',
                      style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
                    ),
                    const SizedBox(height: 24),

                    // Section 1: Color Presets
                    _buildSectionCard(
                      title: 'Theme Presets',
                      subtitle: 'Choose a premium predefined theme palette.',
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.1,
                        ),
                        itemCount: _presets.length,
                        itemBuilder: (context, index) {
                          final name = _presets[index];
                          final palette = ThemeConfig.getAppPalette(name);
                          final isSelected = settings.presetName == name;

                          return Tooltip(
                            message: name,
                            child: InkWell(
                              onTap: () {
                                notifier.updatePreset(name);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: palette.background,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected ? theme.colors.primary : Colors.grey.shade300,
                                    width: isSelected ? 3.0 : 1.0,
                                  ),
                                  boxShadow: isSelected
                                      ? [BoxShadow(color: theme.colors.primary.withOpacity(0.2), blurRadius: 8, spreadRadius: 1)]
                                      : null,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: palette.primary,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: palette.sidebarBackground,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      name.length > 10 ? '${name.substring(0, 8)}...' : name,
                                      style: theme.typography.bodySmall.copyWith(
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        color: isSelected ? theme.colors.primary : theme.colors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section 2: Custom branding color inputs
                    _buildSectionCard(
                      title: 'Custom Brand Overrides',
                      subtitle: 'Specify custom brand colors (HEX code format, e.g. #0A74DA). Leave blank to use preset defaults.',
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildColorTextField(
                                  label: 'Primary Accent Color',
                                  controller: _primaryController,
                                  previewColor: currentPrimary,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildColorTextField(
                                  label: 'Primary Container Color',
                                  controller: _primaryContainerController,
                                  previewColor: currentPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildColorTextField(
                                  label: 'Sidebar Background Color',
                                  controller: _sidebarBgController,
                                  previewColor: currentSidebarBg,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildColorTextField(
                                  label: 'Topbar Background Color',
                                  controller: _topbarBgController,
                                  previewColor: currentTopbarBg,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section 3: Layout Style
                    _buildSectionCard(
                      title: 'Page Layout Mode',
                      subtitle: 'Configure the global alignment structure of sidebars and nav headers.',
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildLayoutCard(
                              title: 'Left Sidebar',
                              icon: Icons.align_horizontal_left,
                              isSelected: settings.layoutStyle == LayoutStyle.verticalLeft,
                              onTap: () => notifier.updateLayoutStyle(LayoutStyle.verticalLeft),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildLayoutCard(
                              title: 'Right Sidebar',
                              icon: Icons.align_horizontal_right,
                              isSelected: settings.layoutStyle == LayoutStyle.verticalRight,
                              onTap: () => notifier.updateLayoutStyle(LayoutStyle.verticalRight),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildLayoutCard(
                              title: 'Top Navigation',
                              icon: Icons.horizontal_distribute,
                              isSelected: settings.layoutStyle == LayoutStyle.horizontal,
                              onTap: () => notifier.updateLayoutStyle(LayoutStyle.horizontal),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildLayoutCard(
                              title: 'Collapsed Sidebar',
                              icon: Icons.view_sidebar_outlined,
                              isSelected: settings.layoutStyle == LayoutStyle.collapsed,
                              onTap: () => notifier.updateLayoutStyle(LayoutStyle.collapsed),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section 4: Localization Settings
                    _buildSectionCard(
                      title: 'Application Language',
                      subtitle: 'Select default localization parameters.',
                      child: Column(
                        children: [
                          ...() {
                            String activeLang = ref.watch(languageProvider);
                            final supportedLangs = activePalette.supportedLanguages.isNotEmpty
                                ? activePalette.supportedLanguages
                                : const ['en', 'fr', 'es'];

                            return supportedLangs.map((lang) {
                              String title = '';
                              String flag = '';
                              if (lang == 'en') {
                                title = 'English';
                                flag = '🇺🇸';
                              } else if (lang == 'fr') {
                                title = 'Français';
                                flag = '🇫🇷';
                              } else if (lang == 'es') {
                                title = 'Español';
                                flag = '🇪🇸';
                              } else if (lang == 'ar') {
                                title = 'العربية';
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
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: isSelected ? theme.colors.primary : Colors.grey.shade200,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    if (context.mounted) {
                                      await context.setLocale(Locale(lang));
                                    }
                                    await ref.read(languageProvider.notifier).setLanguage(lang);
                                    if (lang == 'ar') {
                                      notifier.updateDirection(TextDirection.rtl);
                                    } else {
                                      notifier.updateDirection(TextDirection.ltr);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                    child: Row(
                                      children: [
                                        Text(flag, style: const TextStyle(fontSize: 20)),
                                        const SizedBox(width: 12),
                                        Text(
                                          title,
                                          style: theme.typography.bodyMedium.copyWith(
                                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                          ),
                                        ),
                                        const Spacer(),
                                        if (isSelected)
                                          Icon(Icons.check_circle, color: theme.colors.primary, size: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                          }()
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section 5: Toggle Options
                    _buildSectionCard(
                      title: 'Additional Features',
                      subtitle: 'Advanced display parameters toggles.',
                      child: Column(
                        children: [
                          SwitchListTile(
                            activeColor: theme.colors.primary,
                            title: Text('Right-To-Left Alignment', style: theme.typography.bodyLarge),
                            subtitle: Text('Re-align standard content direction.', style: theme.typography.bodyMedium),
                            value: settings.direction == TextDirection.rtl,
                            onChanged: (val) {
                              notifier.updateDirection(val ? TextDirection.rtl : TextDirection.ltr);
                            },
                          ),
                          const Divider(),
                          SwitchListTile(
                            activeColor: theme.colors.primary,
                            title: Text('Custom Styled Scrollbars', style: theme.typography.bodyLarge),
                            subtitle: Text('Use modern overlays instead of native UI scrollbars.', style: theme.typography.bodyMedium),
                            value: settings.customScrollbars,
                            onChanged: (val) {
                              notifier.toggleScrollbars(val);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Actions bottom bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            notifier.resetToTenantDefault('darkBlueSilver');
                            _primaryController.clear();
                            _primaryContainerController.clear();
                            _sidebarBgController.clear();
                            _topbarBgController.clear();
                          },
                          child: const Text('Reset Defaults'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colors.primary,
                            foregroundColor: theme.colors.onPrimary,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _isSaving ? null : _saveSettings,
                          child: _isSaving
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : const Text('Save Branding & Settings'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ),

          // Right live preview mockup panel
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.grey.shade200)),
                color: theme.colors.surface.withOpacity(0.7),
              ),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Real-Time Branding Preview',
                    style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Preview how your typography, structure, layout, and colors look on a desktop viewport mock.',
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.textSecondary),
                  ),
                  const SizedBox(height: 32),

                  // Desktop Mockup Container
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          // App Window Header bar
                          Container(
                            height: 32,
                            color: Colors.grey.shade200,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red)),
                                const SizedBox(width: 6),
                                Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.orange)),
                                const SizedBox(width: 6),
                                Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green)),
                                const Spacer(),
                                Container(
                                  width: 200,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text('primecare.app/clinic/dashboard', style: TextStyle(fontSize: 9, color: Colors.grey)),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),

                          // Mockup Main Content Area
                          Expanded(
                            child: Row(
                              textDirection: settings.direction,
                              children: [
                                // Mock Sidebar (Left / Right / Collapsed based on layoutStyle)
                                if (settings.layoutStyle == LayoutStyle.verticalLeft ||
                                    settings.layoutStyle == LayoutStyle.verticalRight ||
                                    settings.layoutStyle == LayoutStyle.collapsed)
                                  Container(
                                    width: settings.layoutStyle == LayoutStyle.collapsed ? 48 : 120,
                                    color: currentSidebarBg,
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Sidebar brand header
                                        Container(
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        // Sidebar menu items
                                        ...List.generate(4, (index) => Container(
                                          height: 14,
                                          margin: const EdgeInsets.only(bottom: 8),
                                          decoration: BoxDecoration(
                                            color: index == 0
                                                ? currentPrimary
                                                : Colors.white.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),

                                // Main Portal View (Top Header + Content Workspace)
                                Expanded(
                                  child: Column(
                                    children: [
                                      // Top Header Navbar (If not vertical style, Horizontal takes top bar space)
                                      Container(
                                        height: 40,
                                        color: settings.layoutStyle == LayoutStyle.horizontal ? currentSidebarBg : currentTopbarBg,
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Row(
                                          children: [
                                            if (settings.layoutStyle == LayoutStyle.horizontal) ...[
                                              Container(
                                                width: 60,
                                                height: 18,
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.15),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Container(width: 30, height: 10, color: Colors.white.withOpacity(0.1)),
                                              const SizedBox(width: 8),
                                              Container(width: 30, height: 10, color: Colors.white.withOpacity(0.1)),
                                            ] else ...[
                                              const Icon(Icons.menu, size: 16, color: Colors.white70),
                                            ],
                                            const Spacer(),
                                            Container(
                                              width: 35,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                color: currentPrimaryContainer,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text('EN', style: TextStyle(fontSize: 8, color: currentPrimary, fontWeight: FontWeight.bold)),
                                            ),
                                            const SizedBox(width: 8),
                                            const CircleAvatar(radius: 10, backgroundColor: Colors.white24),
                                          ],
                                        ),
                                      ),

                                      // Main Workspace Layout
                                      Expanded(
                                        child: Container(
                                          color: Colors.grey.shade50,
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Page Title Mock
                                              Container(width: 120, height: 18, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4))),
                                              const SizedBox(height: 16),
                                              // Dashboard Cards Grid Mock
                                              Expanded(
                                                child: GridView.count(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                  childAspectRatio: 1.5,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  children: List.generate(4, (index) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(8),
                                                        border: Border.all(color: Colors.grey.shade200),
                                                      ),
                                                      padding: const EdgeInsets.all(8),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              CircleAvatar(radius: 8, backgroundColor: currentPrimary.withOpacity(0.1), child: Icon(Icons.circle, size: 6, color: currentPrimary)),
                                                              const SizedBox(width: 6),
                                                              Container(width: 40, height: 8, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(2))),
                                                            ],
                                                          ),
                                                          const Spacer(),
                                                          Container(width: 25, height: 12, decoration: BoxDecoration(color: currentPrimaryContainer, borderRadius: BorderRadius.circular(4))),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle, style: context.theme.typography.bodySmall.copyWith(color: Colors.grey.shade500)),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildColorTextField({
    required String label,
    required TextEditingController controller,
    required Color previewColor,
  }) {
    final theme = context.theme;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: theme.typography.bodyMedium.copyWith(color: theme.colors.textSecondary),
        hintText: '#HEXCODE',
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: Container(
          width: 24,
          height: 24,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: previewColor,
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colors.primary, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colors.error),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colors.error, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (val) {
        if (val != null && val.trim().isNotEmpty) {
          final clean = val.replaceAll('#', '').trim();
          if (clean.length != 6 && clean.length != 8) {
            return 'Enter a valid 6 or 8 character HEX color.';
          }
          final hexRegex = RegExp(r'^[0-9a-fA-F]+$');
          if (!hexRegex.hasMatch(clean)) {
            return 'Enter valid hex characters (0-9, A-F).';
          }
        }
        return null;
      },
      onChanged: (_) {
        setState(() {}); // Triggers preview update
      },
    );
  }

  Widget _buildLayoutCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = context.theme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? theme.colors.primary : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? theme.colors.primary : Colors.grey.shade600,
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.typography.bodySmall.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? theme.colors.primary : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
