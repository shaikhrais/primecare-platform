import 'package:primecare_ui/primecare_ui.dart';
import '../governance/screen_registry.dart';


class DynamicScreenView extends StatelessWidget {
  final ScreenMetadata metadata;

  const DynamicScreenView({required this.metadata, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PrimeCareColors.radarDark,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: PrimeCareColors.skyBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                metadata.featureName.toUpperCase(),
                style: const TextStyle(
                  color: PrimeCareColors.skyBlue,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'ID: ${metadata.id}',
              style: const TextStyle(
                color: PrimeCareColors.slate500,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          metadata.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          metadata.description,
          style: const TextStyle(
            color: PrimeCareColors.slate400,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(BuildContext context) {
    return Row(
      children: [
        _buildStatusItem('Status', metadata.lifecycleStatus.name.toUpperCase(), PrimeCareColors.emerald),
        const SizedBox(width: 24),
        _buildStatusItem('Priority', metadata.priority.name.toUpperCase(), PrimeCareColors.amber),
        const SizedBox(width: 24),
        _buildStatusItem('Security', metadata.securityLevel.name.toUpperCase(), PrimeCareColors.rose),
      ],
    );
  }

  Widget _buildStatusItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: PrimeCareColors.slate500,
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGrid(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        _buildComponentCard(
          'Implemented Components',
          metadata.implementedComponents,
          PrimeCareColors.emerald,
        ),
        _buildComponentCard(
          'Pending Components',
          metadata.pendingComponents,
          PrimeCareColors.slate500,
        ),
        _buildDetailsCard(),
      ],
    );
  }

  Widget _buildComponentCard(String title, List<String> components, Color color) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PrimeCareColors.slate800.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          if (components.isEmpty)
            const Text(
              'No components registered.',
              style: TextStyle(color: PrimeCareColors.slate500, fontStyle: FontStyle.italic),
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
                        style: const TextStyle(color: PrimeCareColors.slate300, fontSize: 13),
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PrimeCareColors.slate800.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Architectural Metrics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _buildMetricRow('Parity Score', '${metadata.architecturalParityScore.toInt()}%'),
          _buildMetricRow('Story Points', metadata.storyPoints.toString()),
          _buildMetricRow('Complexity', '${metadata.complexity}/10'),
          _buildMetricRow('UAT Approver', metadata.uatApprover),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: PrimeCareColors.slate500, fontSize: 13)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
