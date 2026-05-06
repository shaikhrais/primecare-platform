import 'package:primecare_ui/primecare_ui.dart';
import '../../generated/locale_keys.g.dart';

/// [View] - Real-time System Telemetry & Performance Monitor
/// Visualizes architectural health, network latency, and service availability.
class SystemMonitoringView extends ConsumerWidget {
  const SystemMonitoringView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return ClinicalGlassPanel(
      title: LocaleKeys.governance_system_monitoring.tr(),
      icon: Icons.monitor_heart_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHealthStatus(context, theme),
          const SizedBox(height: 32),
          _buildMetricGrid(context, theme),
          const SizedBox(height: 32),
          _buildLatencyChartPlaceholder(context, theme),
        ],
      ),
    );
  }

  Widget _buildHealthStatus(BuildContext context, PrimeThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: Colors.green, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Systems Operational',
                  style: theme.typography.h3.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Last verified: 30 seconds ago',
                  style: theme.typography.bodySmall.copyWith(
                    color: Colors.green.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text('Re-Validate'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricGrid(BuildContext context, PrimeThemeData theme) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.5,
      children: [
        _buildMetricCard(
          theme,
          'CPU Usage',
          '14%',
          Icons.memory_rounded,
          Colors.blue,
        ),
        _buildMetricCard(
          theme,
          'RAM Utilization',
          '2.4 GB',
          Icons.storage_rounded,
          Colors.purple,
        ),
        _buildMetricCard(
          theme,
          'API Latency',
          '45ms',
          Icons.speed_rounded,
          Colors.orange,
        ),
        _buildMetricCard(
          theme,
          'Active Sessions',
          '1,248',
          Icons.people_rounded,
          Colors.teal,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    PrimeThemeData theme,
    String label,
    String value,
    IconData icon,
    Color accent,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colors.background.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: theme.typography.bodySmall.copyWith(
                  color: theme.colors.onSurfaceVariant,
                ),
              ),
              Text(
                value,
                style: theme.typography.h3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLatencyChartPlaceholder(
    BuildContext context,
    PrimeThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'API Response Times (24h)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.colors.background.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colors.border,
              style: BorderStyle.none,
            ),
          ),
          child: CustomPaint(painter: _ChartPainter(theme.colors.primary)),
        ),
      ],
    );
  }
}

class _ChartPainter extends CustomPainter {
  final Color color;
  _ChartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.4,
      size.width * 0.5,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.8,
      size.width,
      size.height * 0.3,
    );

    canvas.drawPath(path, paint);

    // Gradient fill
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.3), Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
