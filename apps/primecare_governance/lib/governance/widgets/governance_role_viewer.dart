
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart' as core;


class GovernanceRoleViewer extends ConsumerWidget {
  const GovernanceRoleViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final roles = core.PlatformRole.values.map((r) => core.GovernanceRole(r)).toList();

    if (roles.isEmpty) {
      return const Center(
        child: EmptyState(
          title: 'No Roles Defined',
          subtitle: 'The application has not registered any platform role definitions.',
          icon: LucideIcons.shieldAlert,
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.shieldCheck, size: 28, color: Color(0xFF3B82F6)),
              const SizedBox(width: 12),
              Text(
                'Platform Role Governance',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.2)),
                ),
                child: Text(
                  '${roles.length} Registered Roles',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF3B82F6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Granular activity control and security profile management for all platform actors.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: 420,
            ),
            itemCount: roles.length,
            itemBuilder: (context, index) {
              final roleDef = roles[index];
              return _RoleDefinitionCard(roleDef: roleDef);
            },
          ),
        ],
      ),
    );
  }
}

class _RoleDefinitionCard extends StatelessWidget {
  final core.GovernanceRole roleDef;

  const _RoleDefinitionCard({required this.roleDef});

  @override
  Widget build(BuildContext context) {
    final priorityColor = PrimeCareColors.success;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: priorityColor.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: priorityColor,
                  radius: 20,
                  child: Icon(
                    _getRoleIcon(roleDef.role),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roleDef.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        roleDef.name.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: priorityColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const Divider(),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatItem(
                        label: 'Modules',
                        value: 1.toString(),
                        icon: LucideIcons.layers,
                      ),
                      _StatItem(
                        label: 'Screens',
                        value: roleDef.totalSidebarItems.toString(),
                        icon: LucideIcons.layout,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getRoleIcon(core.PlatformRole role) {
    switch (role) {
      case core.PlatformRole.admin:
        return LucideIcons.shieldCheck;
      case core.PlatformRole.psw:
        return LucideIcons.heartHandshake;
      case core.PlatformRole.ceo:
        return LucideIcons.briefcase;
      case core.PlatformRole.governanceOfficer:
        return LucideIcons.eye;
      case core.PlatformRole.complianceManager:
        return LucideIcons.fileCheck;
      case core.PlatformRole.qa:
        return LucideIcons.testTube;
      default:
        return LucideIcons.user;
    }
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4)),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 9,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
