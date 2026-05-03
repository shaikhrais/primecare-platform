import 'dart:ui';

import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart' hide ScreenRegistry;
import '../governance/screen_registry.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      backgroundColor: Colors.transparent,
      elevation: 0,
      width: 320,
      child: Stack(
        children: [
          // Glassmorphic background - Obsidian Lens
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      PrimeCareColors.radarDark.withValues(alpha: 0.95),
                      PrimeCareColors.radarDark.withValues(alpha: 0.85),
                    ],
                  ),
                  border: Border(
                    right: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              _buildHeader(context),
              _buildVisionControl(context, ref, visionMode),
              const Divider(color: Colors.white10, height: 1),
              _buildSectionHeader('SYSTEM CORE'),
              _buildStaticLink(context, 'Governance Dashboard', Icons.dashboard_outlined, '/'),
              _buildStaticLink(context, 'Verification Center', Icons.verified_user_outlined, '/verification'),
              const SizedBox(height: 16),
              _buildSectionHeader('FEATURE GOVERNANCE'),
              _buildStaticLink(context, 'Proposal Inbox', Icons.inbox_outlined, '/proposals'),
              _buildStaticLink(context, 'New Feature Request', Icons.add_to_photos_outlined, '/proposals/new'),
              const SizedBox(height: 16),
              _buildSectionHeader('ROLE REGISTRIES'),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  children: sortedRoles.map((role) {
                    return _buildRoleGroup(context, role, groupedByRole[role]!);
                  }).toList(),
                ),
              ),
              const Divider(color: Colors.white10, height: 1),
              _buildFooter(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVisionControl(BuildContext context, WidgetRef ref, AuraVisionMode currentMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AURA VISION MODES',
            style: TextStyle(
              color: PrimeCareColors.slate400,
              fontSize: 9,
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
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 64, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PrimeCareColors.skyBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  color: PrimeCareColors.skyBlue,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PRIMECARE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                    ),
                  ),
                  Text(
                    'GOVERNANCE',
                    style: TextStyle(
                      color: PrimeCareColors.slate400,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleGroup(BuildContext context, String role, List<ScreenMetadata> screens) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          role.replaceAll('_', ' ').toUpperCase(),
          style: const TextStyle(
            color: PrimeCareColors.slate300,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
        leading: Icon(
          _getRoleIcon(role),
          color: PrimeCareColors.skyBlue,
          size: 20,
        ),
        iconColor: PrimeCareColors.slate400,
        collapsedIconColor: PrimeCareColors.slate500,
        childrenPadding: const EdgeInsets.only(left: 12),
        children: screens.map((screen) {
          return ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            leading: Icon(
              screen.icon ?? Icons.circle_outlined,
              color: PrimeCareColors.skyBlue.withValues(alpha: 0.5),
              size: 16,
            ),
            title: Text(
              screen.title,
              style: const TextStyle(
                color: PrimeCareColors.slate100,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            hoverColor: Colors.white.withValues(alpha: 0.05),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: PrimeCareColors.slate400,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildStaticLink(BuildContext context, String title, IconData icon, String route) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Icon(icon, color: PrimeCareColors.skyBlue, size: 18),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        context.go(route);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: PrimeCareColors.slate700,
            radius: 18,
            child: Icon(Icons.person_outline, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Admin User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'System Auditor',
                  style: TextStyle(
                    color: PrimeCareColors.slate400,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined, color: PrimeCareColors.rose, size: 20),
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? PrimeCareColors.skyBlue : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected ? [
            BoxShadow(
              color: PrimeCareColors.skyBlue.withValues(alpha: 0.3),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ] : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white70,
            fontSize: 9,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
