import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';
import '../../../../services/dashboard_service.dart';

class CtoDashboard extends ConsumerWidget {
  const CtoDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF020617), // Deep space navy for CTO
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading metrics: $err', style: const TextStyle(color: Colors.white))),
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
                        const Icon(Icons.hub_outlined, color: Colors.blueAccent, size: 28),
                        const SizedBox(width: 12),
                        Text(
                          'Infrastructure & CTO Hub',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Outfit',
                          ),
                        ),
                        const Spacer(),
                        _buildVersionBadge('v4.2.1-stable'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Real-time orchestration of the PrimeCare core engine and Cloudflare edges.',
                      style: TextStyle(color: Colors.blueGrey, fontFamily: 'Inter'),
                    ),
                    const SizedBox(height: 32),

                    // INFRA HUD row
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final cardWidth = constraints.maxWidth > 1200 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: metrics.kpis.map((kpi) => _buildKpi(
                            cardWidth, 
                            kpi.title, 
                            kpi.value, 
                            _getIcon(kpi.title), 
                            _getStatusColor(kpi.status), 
                            kpi.subtitle
                          )).toList(),
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT: Endpoint Status
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Microservice Health Matrix', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    _buildServiceStatus('Core Worker-API', 'OPERATIONAL', Colors.greenAccent),
                                    const Divider(color: Colors.white10, height: 24, thickness: 0.5),
                                    _buildServiceStatus('Auth-Vault v2', 'OPERATIONAL', Colors.greenAccent),
                                    const Divider(color: Colors.white10, height: 24, thickness: 0.5),
                                    _buildServiceStatus('Prisma-Pulse Proxy', 'OPERATIONAL', Colors.greenAccent),
                                    const Divider(color: Colors.white10, height: 24, thickness: 0.5),
                                    _buildServiceStatus('Media Transmuxing', 'OPERATIONAL', Colors.greenAccent),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 24),

                        // RIGHT: Deployments
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Direct Deployment Feed', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: metrics.recentActivity.map((log) => Column(
                                    children: [
                                      AuditLogTile(
                                        title: log.title, 
                                        subtitle: log.subtitle, 
                                        timestamp: log.timestamp, 
                                        icon: _getActivityIcon(log.icon), 
                                        iconColor: _getStatusColor(log.color)
                                      ),
                                      const Divider(color: Colors.white10, height: 16, thickness: 0.5),
                                    ],
                                  )).toList(),
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

  Widget _buildKpi(double width, String title, String value, IconData icon, Color color, [String? subtitle]) {
    return SizedBox(
      width: width,
      child: KpiStatCard(title: title, value: value, subtitle: subtitle, icon: icon, iconColor: color),
    );
  }

  Widget _buildServiceStatus(String name, String status, Color color, [String? note]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                if (note != null) Text(note, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.1)),
        ],
      ),
    );
  }

  Widget _buildVersionBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.blueAccent.withOpacity(0.3))),
      child: Text(text, style: const TextStyle(color: Colors.blueAccent, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Uptime')) return Icons.cloud_done_outlined;
    if (title.contains('Throughput')) return Icons.speed;
    if (title.contains('Connections')) return Icons.storage_outlined;
    if (title.contains('Latency')) return Icons.bolt;
    if (title.contains('Staff')) return Icons.people;
    return Icons.insights;
  }

  IconData _getActivityIcon(String icon) {
    switch (icon) {
      case 'verified': return Icons.verified;
      case 'person_add': return Icons.person_add;
      case 'security': return Icons.security;
      case 'rocket': return Icons.rocket_launch;
      case 'schema': return Icons.schema;
      case 'cleaning': return Icons.cleaning_services;
      default: return Icons.history;
    }
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
      case 'blue':
      case 'indigo': return Colors.blueAccent;
      default: return Colors.blueGrey;
    }
  }
}
