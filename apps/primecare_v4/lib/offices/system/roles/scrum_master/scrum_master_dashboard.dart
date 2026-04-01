import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/api_providers.dart';

class ScrumMasterDashboard extends ConsumerWidget {
  const ScrumMasterDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    ref.watch(dioProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF030712), // Deeper navy for terminal feel
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
                    children: [
                      _buildHudsonCard('UPTIME', '99.98%', Icons.bolt, Colors.greenAccent),
                      const SizedBox(width: 16),
                      _buildHudsonCard('LATENCY', '42ms', Icons.timer, Colors.tealAccent),
                      const SizedBox(width: 16),
                      _buildHudsonCard('THROUGHPUT', '1.2k req/s', Icons.speed, Colors.blueAccent),
                    ],
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
                                children: [
                                  _buildLogEntry('2026-04-01 14:15:22', 'API_HOOK_TRIGGER', 'Auth Token Rotation [User: 0xD2]'),
                                  _buildLogEntry('2026-04-01 14:14:05', 'CACHE_PURGE', 'Global Office Registry Cleared'),
                                  _buildLogEntry('2026-04-01 14:12:33', 'DB_SYNC_EVENT', 'Region: GTA - 15ms'),
                                  _buildLogEntry('2026-04-01 14:10:01', 'CRON_JOB_COMP', 'Tenant Invoice Generation [Prime-Toronto]'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: DLQ Control
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
                                        backgroundColor: Colors.tealAccent.withOpacity(0.1),
                                        foregroundColor: Colors.tealAccent,
                                        side: const BorderSide(color: Colors.tealAccent),
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                      ),
                                    ),
                                  ),
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

  Widget _buildHudsonCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: GlassSurface(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white, fontFamily: 'monospace')),
            Text(label, style: const TextStyle(color: Colors.blueGrey, fontSize: 10, letterSpacing: 1.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusDot(int index) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.tealAccent.withOpacity(0.05),
        border: Border.all(color: Colors.tealAccent.withOpacity(0.2)),
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

  Widget _buildLogEntry(String ts, String type, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('[$ts]', style: const TextStyle(color: Colors.blueGrey, fontSize: 11, fontFamily: 'monospace')),
              const SizedBox(width: 8),
              Text(type, style: const TextStyle(color: Colors.tealAccent, fontSize: 11, fontWeight: FontWeight.bold)),
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
}
