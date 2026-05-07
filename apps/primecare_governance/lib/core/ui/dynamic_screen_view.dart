import 'package:primecare_ui/primecare_ui.dart';
import '../governance/screen_registry.dart';

class DynamicScreenView extends StatelessWidget {
  final ScreenMetadata metadata;

  const DynamicScreenView({required this.metadata, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    
    // Determine status and aesthetics based on lifecycle
    final String statusText;
    final Color statusColor;
    final IconData statusIcon;
    
    switch (metadata.lifecycleStatus) {
      case LifecycleStatus.completed:
        statusText = 'IMPLEMENTED';
        statusColor = Colors.green;
        statusIcon = LucideIcons.checkCircle;
        break;
      case LifecycleStatus.generation:
      case LifecycleStatus.testing:
        statusText = 'STUBBED';
        statusColor = Colors.orange;
        statusIcon = LucideIcons.hammer;
        break;
      case LifecycleStatus.backlog:
      default:
        statusText = 'DECLARED';
        statusColor = theme.colors.warning;
        statusIcon = LucideIcons.fileSearch;
    }

    return Container(
      color: theme.colors.surfaceContainerLowest,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Status Header
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(statusIcon, color: statusColor, size: 80),
                ),
                const SizedBox(height: 24),
                Text(
                  metadata.title,
                  style: theme.typography.h1.copyWith(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: statusColor.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'GOVERNANCE STATUS: $statusText',
                        style: theme.typography.bodyLarge.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 64),
                
                // Content Layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Details
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(theme, 'Development Lifecycle'),
                          const SizedBox(height: 16),
                          _buildLifecycleStepper(theme, metadata.lifecycleStatus),
                          const SizedBox(height: 48),
                          _buildSectionHeader(theme, 'Screen Specifications'),
                          const SizedBox(height: 16),
                          _buildSpecsTable(theme, metadata),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                    // Right Column: Platform Components
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(theme, 'Platform Architecture Status'),
                          const SizedBox(height: 16),
                          _buildArchitectureStatus(theme, statusText),
                          const SizedBox(height: 48),
                          _buildAuditActions(theme),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(PrimeThemeData theme, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: theme.typography.labelMedium.copyWith(
            color: theme.colors.onSurfaceVariant,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(width: 40, height: 3, color: theme.colors.primary),
      ],
    );
  }

  Widget _buildLifecycleStepper(PrimeThemeData theme, LifecycleStatus current) {
    final steps = LifecycleStatus.values;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusLg),
        border: Border.all(color: theme.colors.outlineVariant),
      ),
      child: Column(
        children: steps.map((s) {
          final isPast = s.index < current.index;
          final isCurrent = s == current;
          final color = isPast ? Colors.green : (isCurrent ? theme.colors.primary : theme.colors.onSurfaceVariant.withValues(alpha: 0.3));
          
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Icon(
                  isPast ? LucideIcons.checkCircle2 : (isCurrent ? LucideIcons.circleDot : LucideIcons.circle),
                  size: 20,
                  color: color,
                ),
                const SizedBox(width: 16),
                Text(
                  s.name.toUpperCase(),
                  style: theme.typography.bodyMedium.copyWith(
                    color: isCurrent ? theme.colors.onSurface : theme.colors.onSurfaceVariant,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const Spacer(),
                if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('CURRENT', style: theme.typography.labelSmall.copyWith(color: theme.colors.primary, fontSize: 8)),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSpecsTable(PrimeThemeData theme, ScreenMetadata metadata) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusLg),
        border: Border.all(color: theme.colors.outlineVariant),
      ),
      child: Column(
        children: [
          _buildSpecRow(theme, 'Identifier', metadata.id),
          _buildSpecRow(theme, 'Feature', metadata.featureName),
          _buildSpecRow(theme, 'Route Path', metadata.routePath),
          _buildSpecRow(theme, 'Office', metadata.office),
          _buildSpecRow(theme, 'Security', metadata.securityLevel.name.toUpperCase()),
          _buildSpecRow(theme, 'Story Points', metadata.storyPoints.toString(), isLast: true),
        ],
      ),
    );
  }

  Widget _buildSpecRow(PrimeThemeData theme, String label, String value, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: theme.colors.outlineVariant)),
      ),
      child: Row(
        children: [
          Text(label, style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant)),
          const Spacer(),
          Text(value, style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
        ],
      ),
    );
  }

  Widget _buildArchitectureStatus(PrimeThemeData theme, String screenStatus) {
    final bool isImplemented = screenStatus == 'IMPLEMENTED';
    
    return Column(
      children: [
        _buildArchCard(theme, 'SIDEBAR NAVIGATION', isImplemented ? 'IMPLEMENTED' : 'DECLARED', LucideIcons.layoutPanelLeft),
        const SizedBox(height: 12),
        _buildArchCard(theme, 'PLATFORM TOP BAR', isImplemented ? 'IMPLEMENTED' : 'DECLARED', LucideIcons.layoutPanelTop),
        const SizedBox(height: 12),
        _buildArchCard(theme, 'MAIN CONTENT AREA', screenStatus, LucideIcons.layout),
      ],
    );
  }

  Widget _buildArchCard(PrimeThemeData theme, String label, String status, IconData icon) {
    Color statusColor;
    switch (status.toUpperCase()) {
      case 'IMPLEMENTED': statusColor = Colors.green; break;
      case 'DECLARED': statusColor = theme.colors.primary; break;
      case 'STUBBED': statusColor = Colors.orange; break;
      default: statusColor = theme.colors.onSurfaceVariant;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusLg),
        border: Border.all(color: theme.colors.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(status, style: theme.typography.bodySmall.copyWith(color: statusColor, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Icon(LucideIcons.checkCircle2, color: statusColor.withValues(alpha: 0.3), size: 20),
        ],
      ),
    );
  }

  Widget _buildAuditActions(PrimeThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusLg),
        border: Border.all(color: theme.colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('GOVERNANCE ACTIONS', style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: PrimeButton.primary(
              label: 'Initiate Development',
              icon: LucideIcons.code,
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: PrimeButton.secondary(
              label: 'File Correction Ticket',
              icon: LucideIcons.ticket,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
