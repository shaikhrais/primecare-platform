import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Governance - Category: service | Purpose: Core implementation file for the Platform Usage platform logic.
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PlatformUsageState {
  final List<String> diagnosticLogs;
  final List<Map<String, dynamic>> deviceSessions;
  final String activeLogFilter; // 'all', 'info', 'warn', 'error'
  final bool isRebooting;

  const PlatformUsageState({
    required this.diagnosticLogs,
    required this.deviceSessions,
    required this.activeLogFilter,
    required this.isRebooting,
  });

  PlatformUsageState copyWith({
    List<String>? diagnosticLogs,
    List<Map<String, dynamic>>? deviceSessions,
    String? activeLogFilter,
    bool? isRebooting,
  }) {
    return PlatformUsageState(
      diagnosticLogs: diagnosticLogs ?? this.diagnosticLogs,
      deviceSessions: deviceSessions ?? this.deviceSessions,
      activeLogFilter: activeLogFilter ?? this.activeLogFilter,
      isRebooting: isRebooting ?? this.isRebooting,
    );
  }
}

// --- Controller ---
class PlatformUsageController extends StateNotifier<PlatformUsageState> {
  final Ref ref;
  final Ref _ref;

  PlatformUsageController(this._ref)
      : super(
          const PlatformUsageState(
            diagnosticLogs: [
              'INFO: Gateway service initialized successfully.',
              'INFO: Cache hit ratio at 89.2% for clinical routes.',
              'WARN: Memory utilization exceeds 78% on node-US-EAST-2.',
              'INFO: Telemetry events successfully flushed to Aura server.',
              'ERROR: Timeout connecting to secondary backup database pool.',
              'INFO: Scheduled vacuum jobs completed for ledger transactions table.',
            ],
            deviceSessions: [
              {'device': 'iOS Native App', 'activeUsers': 1420, 'percent': 42},
              {'device': 'Android Native App', 'activeUsers': 1180, 'percent': 35},
              {'device': 'Desktop/Web Portal', 'activeUsers': 780, 'percent': 23},
            ],
            activeLogFilter: 'all',
            isRebooting: false,
          ),
        );

  void setLogFilter(String filter) {
    state = state.copyWith(activeLogFilter: filter);
  }

  void executeSafeSystemReboot(BuildContext context) {
    state = state.copyWith(isRebooting: true);
    _logEvent('cto_platform_usage_reboot', {
      'log_filter_state': state.activeLogFilter,
      'active_sessions_total': 3380,
      'timestamp': DateTime.now().toIso8601String(),
    });

    Future.delayed(const Duration(milliseconds: 2200), () {
      state = state.copyWith(isRebooting: false);
      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          backgroundColor: context.theme.colors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            final theme = context.theme;
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(LucideIcons.power, color: Colors.green),
                      const SizedBox(width: 10),
                      Text(
                        'Safe Reboot Completed',
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Node containers have been sequentially restarted. Load balancer traffic has been re-allocated to secondary standby cluster. System status is green.',
                    style: const TextStyle(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(key: const Key('platform_usage_elevatedbutton_button_1'), 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        foregroundColor: theme.colors.onPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back to Platform Usage'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    });
  }

  void _logEvent(String type, Map<String, dynamic> meta) {
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/features/generated_screens/platform_usage',
            eventType: type,
            metadata: meta,
          );
    } catch (_) {}
  }
}

// --- Provider ---
final platformUsageControllerProvider =
    StateNotifierProvider<PlatformUsageController, PlatformUsageState>((ref) {
  return PlatformUsageController(ref);
});

// --- View ---
class PlatformUsage extends GovernedConsumerWidget {
  const PlatformUsage({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(platformUsageControllerProvider);
    final controller = ref.read(platformUsageControllerProvider.notifier);
    final theme = context.theme;

    final filteredLogs = state.diagnosticLogs.where((log) {
      if (state.activeLogFilter == 'all') return true;
      if (state.activeLogFilter == 'info') return log.startsWith('INFO:');
      if (state.activeLogFilter == 'warn') return log.startsWith('WARN:');
      if (state.activeLogFilter == 'error') return log.startsWith('ERROR:');
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: const Text('Platform Usage & Telemetry Stream'),
        backgroundColor: theme.colors.surface,
        foregroundColor: theme.colors.onSurface,
        elevation: 0,
        actions: [
          IconButton(key: const Key('platform_usage_iconbutton_button_1'), 
            icon: const Icon(LucideIcons.refreshCw),
            onPressed: () {
              ref.invalidate(platformUsageControllerProvider);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI / Stats Grid
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Active User Sessions',
                    value: '3,380 sessions',
                    icon: LucideIcons.laptop,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'System Node Health',
                    value: '98.4% uptime',
                    icon: LucideIcons.heartPulse,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Current Traffic Peak',
                    value: '142 reqs/s',
                    icon: LucideIcons.zap,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Active Sessions Device Breakdown Card
            Card(
              color: theme.colors.surface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: theme.colors.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Live Client Device Breakdown',
                      style: const TextStyle(),
                    ),
                    const SizedBox(height: 16),
                    ...state.deviceSessions.map((session) {
                      final deviceName = session['device'].toString();
                      final count = session['activeUsers'] as int;
                      final pct = session['percent'] as int;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(deviceName, style: const TextStyle()),
                                Text('$count users ($pct%)', style: const TextStyle()),
                              ],
                            ),
                            const SizedBox(height: 6),
                            LinearProgressIndicator(
                              value: pct / 100.0,
                              backgroundColor: theme.colors.border,
                              valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
                              minHeight: 6,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Live Diagnostics Stream Console
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Diagnostics Log Console',
                  style: const TextStyle(),
                ),
                Row(
                  children: [
                    ...['all', 'info', 'warn', 'error'].map((filter) {
                      final isSelected = state.activeLogFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: ChoiceChip(
                          label: Text(filter.toUpperCase()),
                          selected: isSelected,
                          onSelected: (_) => controller.setLogFilter(filter),
                          selectedColor: theme.colors.primary.withValues(alpha: 0.15),
                          labelStyle: TextStyle(
                            color: isSelected ? theme.colors.primary : theme.colors.onSurface,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Log Console Window Card
            Card(
              color: Colors.black.withValues(alpha: 0.9),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                height: 180,
                child: filteredLogs.isEmpty
                    ? const Center(
                        child: Text(
                          'No logs matching selected level filter.',
                          style: TextStyle(color: Colors.grey, fontFamily: 'monospace', fontSize: 12),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredLogs.length,
                        itemBuilder: (context, index) {
                          final log = filteredLogs[index];
                          Color logColor = Colors.green;
                          if (log.startsWith('WARN:')) {
                            logColor = Colors.orange;
                          } else if (log.startsWith('ERROR:')) {
                            logColor = Colors.red;
                          }
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Text(
                              log,
                              style: TextStyle(
                                color: logColor,
                                fontFamily: 'monospace',
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Safe Node Reboot Trigger
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(key: const Key('platform_usage_elevatedbutton_button_2'), 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: state.isRebooting
                    ? null
                    : () => controller.executeSafeSystemReboot(context),
                child: state.isRebooting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(LucideIcons.power, size: 20),
                          SizedBox(width: 8),
                          Text('Execute Safe Platform System Reboot'),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Card(
      color: theme.colors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style: const TextStyle(),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
