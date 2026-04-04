import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/dashboard_providers.dart';

class ScrumMasterDashboard extends ConsumerWidget {
  const ScrumMasterDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF030712), // Deeper navy for terminal feel
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.tealAccent)),
        error: (err, stack) => Center(child: Text('TERMINAL_ERR: $err', style: const TextStyle(color: Colors.redAccent, fontFamily: 'monospace'))),
        data: (metrics) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                      children: [
                        const Icon(Icons.terminal, color: Colors.tealAccent, size: 28),
                        const SizedBox(width: 12),
                        Text(
                          'Operations Terminal',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Outfit',
                          ),
                        ),
                        const Spacer(),
                        _buildPulseIndicator('SYSTEM_HEALTH: NOMINAL'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Technical audit and real-time backend orchestration.',
                      style: TextStyle(color: Colors.blueGrey, fontFamily: 'Inter'),
                    ),
                    const SizedBox(height: 32),

                    // SYSTEM HEALTH HUD
                    Row(
                      children: metrics.kpis.take(3).map((kpi) => _buildHudsonCard(
                        kpi.title, 
                        kpi.value, 
                        _getIcon(kpi.title), 
                        _getStatusColor(kpi.status)
                      )).toList(),
                    ),

                    const SizedBox(height: 32),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT: Data Sync Status (36 Roles)
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('36-Role Data Sync Matrix', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(20),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: List.generate(36, (index) => _buildStatusDot(index)),
                                ),
                              ),
                              
                              const SizedBox(height: 32),
                              
                              const Text('System Audit Log', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: metrics.recentActivity.map((log) => _buildLogEntry(
                                    log.timestamp, 
                                    log.title, 
                                    log.subtitle,
                                    _getStatusColor(log.color)
                                  )).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 24),

                        // RIGHT: DLQ Control & 110 Screen Master Index
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Dead Letter Queue (DLQ)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    const Icon(Icons.dangerous, color: Colors.redAccent, size: 48),
                                    const SizedBox(height: 16),
                                    const Text('34 Orphaned Payloads', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                    const Text('Waiting in queue [worker-dlq-01]', style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.flash_on),
                                        label: const Text('Flush Dead Letter Queue'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.tealAccent.withValues(alpha: 0.1),
                                          foregroundColor: Colors.tealAccent,
                                          side: const BorderSide(color: Colors.tealAccent),
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 32),
                              
                              const Text('110 Master Archetypes UI Index', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  height: 400, // Fixed height with scroll for the 110 blocks
                                  child: SingleChildScrollView(
                                    child: Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: List.generate(110, (index) => _buildFeatureDot(context, index + 1)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHudsonCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: GlassSurface(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 12),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white, fontFamily: 'monospace')),
              Text(label, style: const TextStyle(color: Colors.blueGrey, fontSize: 10, letterSpacing: 1.5), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusDot(int index) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.tealAccent.withValues(alpha: 0.05),
        border: Border.all(color: Colors.tealAccent.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          'R${index + 1}', 
          style: const TextStyle(color: Colors.tealAccent, fontSize: 9, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildFeatureDot(BuildContext context, int index) {
    return InkWell(key: const Key('data-status-id=system-scrum-scrum-action-1'), 
      onTap: () => context.go('/provider/feature/stitch_feature_$index'),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent.withValues(alpha: 0.1),
          border: Border.all(color: Colors.deepPurpleAccent.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'F$index', 
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildLogEntry(String ts, String type, String details, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('[$ts]', style: const TextStyle(color: Colors.blueGrey, fontSize: 11, fontFamily: 'monospace')),
              const SizedBox(width: 8),
              Text(type, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          Text(details, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildPulseIndicator(String text) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
      ],
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('UPTIME')) return Icons.bolt;
    if (title.contains('LATENCY')) return Icons.timer;
    if (title.contains('THROUGHPUT')) return Icons.speed;
    return Icons.settings_input_component;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
      case 'green':
      case 'teal': return Colors.tealAccent;
      case 'warning':
      case 'orange': return Colors.orangeAccent;
      case 'danger':
      case 'red': return Colors.redAccent;
      case 'info':
      case 'blue': return Colors.blueAccent;
      default: return Colors.blueGrey;
    }
  }
}
