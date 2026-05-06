import 'package:primecare_ui/primecare_ui.dart';
import '../governance/screen_registry.dart';

class DynamicScreenView extends StatelessWidget {
  final ScreenMetadata metadata;

  const DynamicScreenView({required this.metadata, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    
      decoration: BoxDecoration(
        color: theme.colors.surfaceContainerLowest,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 32),
            _buildStatusRow(context),
            const SizedBox(height: 32),
            _buildGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = context.theme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(theme.radiusSm),
              ),
              child: Text(
                metadata.featureName.toUpperCase(),
                style: TextStyle(
                  color: theme.colors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'ID: ${metadata.id}',
              style: TextStyle(
                color: theme.colors.onSurfaceVariant,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          metadata.title,
          style: theme.typography.h1,
        ),
        const SizedBox(height: 8),
        Text(
          metadata.description,
          style: TextStyle(
            color: theme.colors.textSecondary,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: [
        _buildStatusItem(context, 'Status', metadata.lifecycleStatus.name.toUpperCase(), theme.colors.success),
        const SizedBox(width: 24),
        _buildStatusItem(context, 'Priority', metadata.priority.name.toUpperCase(), theme.colors.warning),
        const SizedBox(width: 24),
        _buildStatusItem(context, 'Security', metadata.securityLevel.name.toUpperCase(), theme.colors.error),
      ],
    );
  }

  Widget _buildStatusItem(BuildContext context, String label, String value, Color color) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: theme.colors.onSurfaceVariant,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: theme.typography.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGrid(BuildContext context) {
    final theme = context.theme;
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        _buildComponentCard(
          context,
          'Implemented Components',
          metadata.implementedComponents,
          theme.colors.success,
        ),
        _buildComponentCard(
          context,
          'Pending Components',
          metadata.pendingComponents,
          theme.colors.textSecondary,
        ),
        _buildDetailsCard(context),
      ],
    );
  }

  Widget _buildComponentCard(BuildContext context, String title, List<String> components, Color color) {
    final theme = context.theme;
    return Container(
      width: 340,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusLg),
        border: Border.all(color: theme.colors.outlineVariant),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.typography.h3,
          ),
          const SizedBox(height: 16),
          if (components.isEmpty)
            Text(
              'No components registered.',
              style: TextStyle(color: theme.colors.onSurfaceVariant, fontStyle: FontStyle.italic),
            )
          else
            ...components.map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline, size: 14, color: color),
                      const SizedBox(width: 8),
                      Text(
                        c,
                        style: TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 13),
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context) {
    final theme = context.theme;
    return Container(
      width: 340,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusLg),
        border: Border.all(color: theme.colors.outlineVariant),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Architectural Metrics',
            style: theme.typography.h3,
          ),
          const SizedBox(height: 16),
          _buildMetricRow(context, 'Parity Score', '${metadata.architecturalParityScore.toInt()}%'),
          _buildMetricRow(context, 'Story Points', metadata.storyPoints.toString()),
          _buildMetricRow(context, 'Complexity', '${metadata.complexity}/10'),
          _buildMetricRow(context, 'UAT Approver', metadata.uatApprover),
        ],
      ),
    );
  }

  Widget _buildMetricRow(BuildContext context, String label, String value) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.typography.bodySmall),
          Text(value, style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
