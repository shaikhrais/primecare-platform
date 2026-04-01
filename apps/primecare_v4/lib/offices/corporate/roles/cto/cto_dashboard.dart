import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/api_providers.dart';

class CtoDashboard extends ConsumerWidget {
  const CtoDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    ref.watch(dioProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF020617), // Deep space navy for CTO
      body: CustomScrollView(
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
                        children: [
                          _buildKpi(cardWidth, 'Global Uptime', '99.99%', Icons.cloud_done_outlined, Colors.greenAccent, 'Last 30 days'),
                          _buildKpi(cardWidth, 'API Throughput', '14.2k req/s', Icons.speed, Colors.blueAccent, 'Peak: 18k'),
                          _buildKpi(cardWidth, 'DB Connections', '42/100', Icons.storage_outlined, Colors.purpleAccent, 'Healthy pool'),
                          _buildKpi(cardWidth, 'Edge Latency', '22ms', Icons.bolt, Colors.tealAccent, 'Cloudflare Region: W-USR'),
                        ],
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
                            const Text('Microservice Health Matrix', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildServiceStatus('Core Worker-API', 'OPERATIONAL', Colors.greenAccent),
                                  const Divider(color: Colors.white10, height: 24, thickness: 0.5),
                                  _buildServiceStatus('Auth-Vault v2', 'OPERATIONAL', Colors.greenAccent),
                                  const Divider(color: Colors.white10, height: 24, thickness: 0.5),
                                  _buildServiceStatus('Prisma-Pulse Proxy', 'DEGRADED', Colors.orangeAccent, 'Increased latency in US-East'),
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
                            const Text('Direct Deployment Feed', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  AuditLogTile(title: 'Prod Push: Hotfix 02', subtitle: 'by TechArchitect', timestamp: '5m ago', icon: Icons.rocket_launch, iconColor: Colors.blueAccent),
                                  const Divider(color: Colors.white10, height: 16, thickness: 0.5),
                                  AuditLogTile(title: 'DB Schema Migration', subtitle: 'Role Registry Sync', timestamp: '2h ago', icon: Icons.schema, iconColor: Colors.purpleAccent),
                                  const Divider(color: Colors.white10, height: 16, thickness: 0.5),
                                  AuditLogTile(title: 'Edge Cache Purge', subtitle: 'Global Wipe', timestamp: '5h ago', icon: Icons.cleaning_services, iconColor: Colors.tealAccent),
                                ],
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
}
