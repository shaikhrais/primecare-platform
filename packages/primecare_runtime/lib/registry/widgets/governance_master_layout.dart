// Existing host retains the authenticated, language, drawer and role-switcher composition.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeIcon, PrimeText, PrimeIconButton, PrimeTextField;
import 'package:primecare_runtime/theme/prime_semantic_palette.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:primecare_models/src/models/auth_state.dart';
import 'package:primecare_portal_shell/governance_master_layout.dart';
import 'package:primecare_portal_state/models/governance_role.dart';
import '../platform_role.dart';
import '../role_registry.dart';
import '../../models/governance_role.dart';
import '../../auth_service.dart';
import '../../theme/theme_settings_provider.dart';
import 'theme_settings_drawer.dart';
import 'theme_center_panel.dart' show PrimeToolbarTextScale, themeCenterText;
import '../../src/localization/language_provider.dart';

class GovernanceMasterLayout extends GovernanceMasterLayoutBase {
  const GovernanceMasterLayout({super.key,required super.application,required super.activeRole,required super.child});
  @override ThemeSettingsState watchSettings(WidgetRef ref) => ref.watch(themeSettingsProvider);
  @override AuthState watchAccount(WidgetRef ref) => ref.watch(authProvider);
  @override GovernanceRoleBase roleBinding() => GovernanceRole(activeRole);
  @override Widget settingsDrawer(String defaultPreset) => ThemeSettingsDrawer(tenantDefaultPreset: defaultPreset);
  @override String watchLanguage(WidgetRef ref) => ref.watch(languageProvider);
  @override Future<void> setLanguage(WidgetRef ref,String language) => ref.read(languageProvider.notifier).setLanguage(language);
  @override Widget toolbarTextScale(Color foreground) => PrimeToolbarTextScale(foreground: foreground);
  @override String saveTooltip(BuildContext context) => themeCenterText(context,'save');
  @override void logout(WidgetRef ref) { ref.read(authProvider.notifier).logout(); }
}

class _RoleSwitcherDialog extends StatefulWidget {
  final PlatformRole activeRole;
  final WidgetRef ref;

  const _RoleSwitcherDialog({
    required this.activeRole,
    required this.ref,
  });

  @override
  State<_RoleSwitcherDialog> createState() => _RoleSwitcherDialogState();
}

class _RoleSwitcherDialogState extends State<_RoleSwitcherDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allRoles = RoleRegistry.getAllRoles();

    // Filter roles
    final filteredRoles = allRoles.where((metadata) {
      final query = _searchQuery.toLowerCase();
      final displayName = metadata.role.displayName.toLowerCase();
      final category = metadata.category.toLowerCase();
      final portal = metadata.defaultPortal.toLowerCase();
      final access = metadata.accessLevel.toLowerCase();
      return displayName.contains(query) ||
          category.contains(query) ||
          portal.contains(query) ||
          access.contains(query);
    }).toList();

    // Group by category
    final Map<String, List<RoleMetadata>> grouped = {};
    for (final roleMeta in filteredRoles) {
      grouped.putIfAbsent(roleMeta.category, () => []).add(roleMeta);
    }

    // Sort categories alphabetically
    final sortedCategories = grouped.keys.toList()..sort();

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0),
      elevation: 0,
      child: Center(
        child: Container(
          width: 580,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.primaryColor.withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.25),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: PrimeIcon(
                        LucideIcons.shieldAlert,
                        color: theme.primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimeText(
                            'Cross-Role Intelligence Switcher',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          PrimeText(
                            'Select a simulated active role to update navigation topology',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PrimeIconButton(
                      icon: const PrimeIcon(LucideIcons.x, size: 18),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PrimeTextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search roles by name, category, or portal...',
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
                    ),
                    prefixIcon: PrimeIcon(
                      LucideIcons.search,
                      size: 16,
                      color: theme.primaryColor.withValues(alpha: 0.7),
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                            child: PrimeIcon(
                              LucideIcons.xCircle,
                              size: 16,
                              color: theme.primaryColor.withValues(alpha: 0.7),
                            ),
                          )
                        : null,
                    filled: true,
                    fillColor: theme.primaryColor.withValues(alpha: 0.03),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: theme.primaryColor.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Roles List
              Expanded(
                child: filteredRoles.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimeIcon(
                              LucideIcons.searchCode,
                              size: 40,
                              color: theme.primaryColor.withValues(alpha: 0.4),
                            ),
                            const SizedBox(height: 12),
                            PrimeText(
                              'No matching roles found',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        itemCount: sortedCategories.length,
                        itemBuilder: (context, index) {
                          final category = sortedCategories[index];
                          final categoryRoles = grouped[category]!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: PrimeText(
                                  category.toUpperCase(),
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              ...categoryRoles.map((roleMeta) {
                                final isSelected = roleMeta.role == widget.activeRole;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: _RoleTile(
                                    roleMeta: roleMeta,
                                    isSelected: isSelected,
                                    onTap: () {
                                      // 1. Simulate Session
                                      widget.ref.read(authProvider.notifier)
                                          .simulateRoleSession(roleMeta.role.nameSnake);
                                      // 2. Resolve destination route
                                      final route = AuthNotifier.getDashboardRouteForRole(roleMeta.role.nameSnake);
                                      // 3. Close switcher dialog
                                      Navigator.of(context).pop();
                                      // 4. Navigate
                                      context.go(route);
                                    },
                                  ),
                                );
                              }),
                              const SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
              ),

              // Bottom HUD indicator showing count
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: theme.primaryColor.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimeText(
                      'Total Mapped: ${allRoles.length} Roles',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.textTheme.labelSmall?.color?.withValues(alpha: 0.6),
                      ),
                    ),
                    PrimeText(
                      'Filtered: ${filteredRoles.length}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleTile extends StatefulWidget {
  final RoleMetadata roleMeta;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleTile({
    required this.roleMeta,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_RoleTile> createState() => _RoleTileState();
}

class _RoleTileState extends State<_RoleTile> {
  bool _isHovered = false;

  Color _getAccessColor(String accessLevel) {
    switch (accessLevel.toLowerCase()) {
      case 'admin':
        return PrimeSemanticPalette.of(context, PrimeSemanticTone.error).accent;
      case 'compliance':
        return PrimeSemanticPalette.of(context, PrimeSemanticTone.secondary).accent;
      case 'write':
        return PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).accent;
      case 'read':
        return PrimeSemanticPalette.of(context, PrimeSemanticTone.success).accent;
      default:
        return Theme.of(context).colorScheme.surfaceContainerHigh;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accessColor = _getAccessColor(widget.roleMeta.accessLevel);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? theme.primaryColor.withValues(alpha: 0.08)
                : (_isHovered
                    ? theme.primaryColor.withValues(alpha: 0.03)
                    : theme.cardColor),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.isSelected
                  ? theme.primaryColor
                  : (_isHovered
                      ? theme.primaryColor.withValues(alpha: 0.3)
                      : theme.primaryColor.withValues(alpha: 0.06)),
              width: widget.isSelected ? 1.5 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Icon Badge with beautiful layout
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? theme.primaryColor.withValues(alpha: 0.1)
                      : theme.primaryColor.withValues(alpha: 0.04),
                  shape: BoxShape.circle,
                ),
                child: PrimeIcon(
                  widget.isSelected ? LucideIcons.checkCircle2 : LucideIcons.shield,
                  color: widget.isSelected ? theme.primaryColor : theme.primaryColor.withValues(alpha: 0.7),
                  size: 16,
                ),
              ),
              const SizedBox(width: 14),

              // Title and portal info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimeText(
                      widget.roleMeta.role.displayName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w600,
                        color: widget.isSelected ? theme.primaryColor : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        PrimeIcon(
                          LucideIcons.globe,
                          size: 10,
                          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
                        ),
                        const SizedBox(width: 4),
                        PrimeText(
                          widget.roleMeta.defaultPortal,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Access badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: PrimeSemanticPalette.tint(context, accessColor, alpha: .1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: accessColor.withValues(alpha: 0.25),
                  ),
                ),
                child: PrimeText(
                  widget.roleMeta.accessLevel.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: PrimeSemanticPalette.onTint(context, accessColor, alpha: .1),
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
