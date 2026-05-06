import 'dart:ui';

import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart' hide ScreenRegistry;
import '../governance/screen_registry.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final visionMode = ref.watch(auraVisionProvider);
    // In a real app, this would come from a role provider
    const String userRole = 'admin';

    final screens = ScreenRegistry.screens.values.where(
      (s) => s.allowedRoles.contains(userRole)
    ).toList();

    // Group screens by primary Role (as defined in ScreenMetadata.role)
    final Map<String, List<ScreenMetadata>> groupedByRole = {};
    for (var screen in screens) {
      final roleKey = screen.role;
      if (!groupedByRole.containsKey(roleKey)) {
        groupedByRole[roleKey] = [];
      }
      groupedByRole[roleKey]!.add(screen);
    }

    final sortedRoles = groupedByRole.keys.toList()..sort();

    return Drawer(
      backgroundColor: theme.colors.surface,
      width: 300,
      child: Column(
        children: [
          _buildHeader(context),
          _buildVisionControl(context, ref, visionMode),
          Divider(color: theme.colors.outlineVariant, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                _buildSectionHeader(context, 'SYSTEM CORE'),
                _buildStaticLink(context, 'Governance HUD', Icons.radar_outlined, '/governance/hud'),
                _buildStaticLink(context, 'Governance Dashboard', Icons.dashboard_outlined, '/'),
                _buildStaticLink(context, 'Verification Center', Icons.verified_user_outlined, '/verification'),
                const SizedBox(height: 16),
                _buildSectionHeader(context, 'FEATURE GOVERNANCE'),
                _buildStaticLink(context, 'Proposal Inbox', Icons.inbox_outlined, '/proposals'),
                _buildStaticLink(context, 'New Feature Request', Icons.add_to_photos_outlined, '/proposals/new'),
                const SizedBox(height: 16),
                _buildSectionHeader(context, 'ROLE REGISTRIES'),
                ...sortedRoles.map((role) {
                  return _buildRoleGroup(context, role, groupedByRole[role]!);
                }).toList(),
                const SizedBox(height: 16),
                _buildSectionHeader(context, 'DESIGN & DEBUG'),
                _buildStaticLink(context, 'Theme Center', Icons.palette_outlined, '/debug/theme-center'),
                _buildStaticLink(context, 'Kitchen Sink', Icons.widgets_outlined, '/debug/kitchen-sink'),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Divider(color: theme.colors.outlineVariant, height: 1),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildVisionControl(BuildContext context, WidgetRef ref, AuraVisionMode currentMode) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AURA VISION MODES',
            style: theme.typography.bodySmall.copyWith(
              color: theme.colors.onSurfaceVariant,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _VisionButton(
                label: 'LIVE',
                isSelected: currentMode == AuraVisionMode.live,
                onTap: () => ref.read(auraVisionProvider.notifier).setMode(AuraVisionMode.live),
              ),
              _VisionButton(
                label: 'HDL',
                isSelected: currentMode == AuraVisionMode.highFidelity,
                onTap: () => ref.read(auraVisionProvider.notifier).setMode(AuraVisionMode.highFidelity),
              ),
              _VisionButton(
                label: 'GRID',
                isSelected: currentMode == AuraVisionMode.blueprint,
                onTap: () => ref.read(auraVisionProvider.notifier).setMode(AuraVisionMode.blueprint),
              ),
              _VisionButton(
                label: 'AUDIT',
                isSelected: currentMode == AuraVisionMode.auraAudit,
                onTap: () => ref.read(auraVisionProvider.notifier).setMode(AuraVisionMode.auraAudit),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 64, 24, 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(theme.radiusXs),
            ),
            child: Icon(
              Icons.shield_outlined,
              color: theme.colors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PRIMECARE',
                style: theme.typography.h3.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'GOVERNANCE',
                style: theme.typography.bodySmall.copyWith(
                  color: theme.colors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleGroup(BuildContext context, String role, List<ScreenMetadata> screens) {
    final theme = context.theme;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          role.replaceAll('_', ' ').toUpperCase(),
          style: theme.typography.bodySmall.copyWith(
            color: theme.colors.onSurfaceVariant,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        leading: Icon(
          _getRoleIcon(role),
          color: theme.colors.primary,
          size: 18,
        ),
        iconColor: theme.colors.onSurfaceVariant,
        collapsedIconColor: theme.colors.onSurfaceVariant,
        childrenPadding: const EdgeInsets.only(left: 12),
        children: screens.map((screen) {
          return ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            leading: Icon(
              screen.icon ?? Icons.circle_outlined,
              color: theme.colors.primary.withValues(alpha: 0.5),
              size: 14,
            ),
            title: Text(
              screen.title,
              style: theme.typography.bodySmall,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(theme.radiusXs)),
            onTap: () {
              context.go(screen.routePath);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  IconData _getRoleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'admin': return Icons.admin_panel_settings_outlined;
      case 'care_angel': return Icons.volunteer_activism_outlined;
      case 'doctor': return Icons.medical_services_outlined;
      case 'patient': return Icons.person_search_outlined;
      case 'finance': return Icons.payments_outlined;
      case 'logistics': return Icons.local_shipping_outlined;
      case 'compliance': return Icons.fact_check_outlined;
      default: return Icons.folder_open_outlined;
    }
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: theme.colors.onSurfaceVariant,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildStaticLink(BuildContext context, String title, IconData icon, String route) {
    final theme = context.theme;
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: theme.colors.primary, size: 18),
      title: Text(
        title,
        style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.w500),
      ),
      onTap: () {
        context.go(route);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: theme.colors.surfaceContainer,
            radius: 18,
            child: Icon(Icons.person_outline, color: theme.colors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Admin User',
                  style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  'System Auditor',
                  style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout_outlined, color: theme.colors.error, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _VisionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _VisionButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(theme.radiusXs),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.primary : theme.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(theme.radiusXs),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? theme.colors.onPrimary : theme.colors.onSurfaceVariant,
            fontSize: 9,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

