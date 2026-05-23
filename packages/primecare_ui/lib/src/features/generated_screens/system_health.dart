// Governance - Category: service | Purpose: Core implementation file for the System Health platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class SystemHealthState {
  final double cpuUsage;
  final double memoryUsage;
  final int activeConnections;
  final int idleConnections;
  final int maxConnections;
  final List<int> latencyHistory;
  final List<Map<String, dynamic>> diagnosticLogs;
  final String activeLogLevelFilter;
  final bool isRebooting;
  final int rebootCountdown;
  final bool isMutatingState;

  const SystemHealthState({
    required this.cpuUsage,
    required this.memoryUsage,
    required this.activeConnections,
    required this.idleConnections,
    required this.maxConnections,
    required this.latencyHistory,
    required this.diagnosticLogs,
    required this.activeLogLevelFilter,
    required this.isRebooting,
    required this.rebootCountdown,
    required this.isMutatingState,
  });

  SystemHealthState copyWith({
    double? cpuUsage,
    double? memoryUsage,
    int? activeConnections,
    int? idleConnections,
    int? maxConnections,
    List<int>? latencyHistory,
    List<Map<String, dynamic>>? diagnosticLogs,
    String? activeLogLevelFilter,
    bool? isRebooting,
    int? rebootCountdown,
    bool? isMutatingState,
  }) {
    return SystemHealthState(
      cpuUsage: cpuUsage ?? this.cpuUsage,
      memoryUsage: memoryUsage ?? this.memoryUsage,
      activeConnections: activeConnections ?? this.activeConnections,
      idleConnections: idleConnections ?? this.idleConnections,
      maxConnections: maxConnections ?? this.maxConnections,
      latencyHistory: latencyHistory ?? this.latencyHistory,
      diagnosticLogs: diagnosticLogs ?? this.diagnosticLogs,
      activeLogLevelFilter: activeLogLevelFilter ?? this.activeLogLevelFilter,
      isRebooting: isRebooting ?? this.isRebooting,
      rebootCountdown: rebootCountdown ?? this.rebootCountdown,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class SystemHealthController extends StateNotifier<SystemHealthState> {
  final Ref _ref;

  SystemHealthController(this._ref)
      : super(
          const SystemHealthState(
            cpuUsage: 34.5,
            memoryUsage: 58.2,
            activeConnections: 18,
            idleConnections: 32,
            maxConnections: 100,
            latencyHistory: [42, 45, 38, 52, 49, 41, 44, 40, 46, 43],
            diagnosticLogs: [
              {
                'timestamp': '09:50:12',
                'level': 'info',
                'message': 'API gateway initialization successful.',
              },
              {
                'timestamp': '09:51:04',
                'level': 'info',
                'message': 'Database connection pool warmed up with 50 instances.',
              },
              {
                'timestamp': '09:52:18',
                'level': 'warning',
                'message': 'High connection count spike detected on Regional Microservice.',
              },
              {
                'timestamp': '09:53:45',
                'level': 'info',
                'message': 'Automated log compaction complete.',
              },
            ],
            activeLogLevelFilter: 'all',
            isRebooting: false,
            rebootCountdown: 0,
            isMutatingState: false,
          ),
        );

  void updateCpuUsage(double val) {
    state = state.copyWith(cpuUsage: double.parse(val.toStringAsFixed(1)));
  }

  void updateMemoryUsage(double val) {
    state = state.copyWith(memoryUsage: double.parse(val.toStringAsFixed(1)));
  }

  void simulateLoadAdjust() {
    state = state.copyWith(isMutatingState: true);
    
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/offices/corporate/roles/cto/system-health',
            eventType: 'system_load_simulation_adjusted',
            metadata: {
              'cpuUsage': state.cpuUsage,
              'memoryUsage': state.memoryUsage,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final nextLatency = (state.cpuUsage * 0.8 + 20 + (state.activeConnections * 1.5)).toInt();
      final updatedHistory = [...state.latencyHistory.sublist(1), nextLatency];

      state = state.copyWith(
        latencyHistory: updatedHistory,
        diagnosticLogs: [
          {
            'timestamp': DateTime.now().toIso8601String().substring(11, 19),
            'level': 'info',
            'message': 'Resource limit override updated: CPU ${state.cpuUsage}%, Mem ${state.memoryUsage}%. Latency: ${nextLatency}ms.',
          },
          ...state.diagnosticLogs,
        ],
        isMutatingState: false,
      );
    });
  }

  void adjustConnections(int delta) {
    final nextActive = (state.activeConnections + delta).clamp(0, state.maxConnections - state.idleConnections);
    
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/offices/corporate/roles/cto/system-health',
            eventType: 'db_connections_scaled',
            metadata: {'delta': delta, 'activeConnections': nextActive},
          );
    } catch (_) {}

    final logMessage = delta > 0 
        ? 'Allocated $delta database connection channels to pool.' 
        : 'Released ${delta.abs()} connection channels back to pool.';

    state = state.copyWith(
      activeConnections: nextActive,
      diagnosticLogs: [
        {
          'timestamp': DateTime.now().toIso8601String().substring(11, 19),
          'level': 'info',
          'message': logMessage,
        },
        ...state.diagnosticLogs,
      ],
    );
  }

  void generateTestLog(String level, String message) {
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/offices/corporate/roles/cto/system-health',
            eventType: 'diagnostic_log_inserted',
            metadata: {'level': level, 'message': message},
          );
    } catch (_) {}

    state = state.copyWith(
      diagnosticLogs: [
        {
          'timestamp': DateTime.now().toIso8601String().substring(11, 19),
          'level': level,
          'message': message,
        },
        ...state.diagnosticLogs,
      ],
    );
  }

  void clearLogs() {
    state = state.copyWith(diagnosticLogs: []);
  }

  void setLogLevelFilter(String filter) {
    state = state.copyWith(activeLogLevelFilter: filter);
  }

  void triggerReboot() {
    if (state.isRebooting) return;
    
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/offices/corporate/roles/cto/system-health',
            eventType: 'system_reboot_initiated',
            metadata: {'operator': 'CTO'},
          );
    } catch (_) {}

    state = state.copyWith(
      isRebooting: true,
      rebootCountdown: 5,
      diagnosticLogs: [
        {
          'timestamp': DateTime.now().toIso8601String().substring(11, 19),
          'level': 'warning',
          'message': 'CRITICAL: Graceful system reboot sequence initiated by CTO.',
        },
        ...state.diagnosticLogs,
      ],
    );

    _runRebootCountdown();
  }

  void _runRebootCountdown() async {
    for (int i = 5; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      state = state.copyWith(
        rebootCountdown: i - 1,
        diagnosticLogs: [
          {
            'timestamp': DateTime.now().toIso8601String().substring(11, 19),
            'level': 'info',
            'message': 'Reboot sequence in progress: ${i - 1} seconds remaining...',
          },
          ...state.diagnosticLogs,
        ],
      );
    }

    state = state.copyWith(
      isRebooting: false,
      cpuUsage: 14.2,
      memoryUsage: 22.8,
      activeConnections: 5,
      idleConnections: 45,
      latencyHistory: [41, 40, 39, 42, 45, 41, 40, 42, 38, 41],
      diagnosticLogs: [
        {
          'timestamp': DateTime.now().toIso8601String().substring(11, 19),
          'level': 'info',
          'message': 'SUCCESS: System safely rebooted and operational integrity confirmed.',
        },
        ...state.diagnosticLogs,
      ],
    );

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/offices/corporate/roles/cto/system-health',
            eventType: 'system_reboot_completed',
            metadata: {'status': 'success'},
          );
    } catch (_) {}
  }
}

// --- Provider ---
final systemHealthControllerProvider =
    StateNotifierProvider<SystemHealthController, SystemHealthState>((ref) {
  return SystemHealthController(ref);
});

// --- View ---
class SystemHealth extends GovernedConsumerWidget {
  const SystemHealth({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(systemHealthControllerProvider);
    final controller = ref.read(systemHealthControllerProvider.notifier);
    final theme = context.theme;

    // Filtered diagnostic logs
    final filteredLogs = state.diagnosticLogs.where((log) {
      if (state.activeLogLevelFilter == 'all') return true;
      return log['level'] == state.activeLogLevelFilter;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.cpu, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'CTO Systems Health & Infrastructure Console',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'SYSTEM ONLINE',
                  style: theme.typography.bodyMedium.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                Text(
                  'Real-time Cluster Telemetry',
                  style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  'Live operational health indicators, database pool ratios, and sandbox simulation sliders.',
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                ),
                const SizedBox(height: 24),

                // Top Metrics Grid
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CPU usage card
                    Expanded(
                      child: _StatCard(
                        title: 'Simulated CPU Load',
                        value: '${state.cpuUsage}%',
                        icon: LucideIcons.barChart2,
                        color: _getColorForPercent(state.cpuUsage),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: state.cpuUsage / 100,
                              backgroundColor: theme.colors.border,
                              color: _getColorForPercent(state.cpuUsage),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Memory Footprint
                    Expanded(
                      child: _StatCard(
                        title: 'RAM Memory Footprint',
                        value: '${state.memoryUsage}%',
                        icon: LucideIcons.hardDrive,
                        color: _getColorForPercent(state.memoryUsage),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: state.memoryUsage / 100,
                              backgroundColor: theme.colors.border,
                              color: _getColorForPercent(state.memoryUsage),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Average API Latency
                    Expanded(
                      child: _StatCard(
                        title: 'API Gateway Latency',
                        value: '${_calculateAvgLatency(state.latencyHistory)}ms',
                        icon: LucideIcons.clock,
                        color: theme.colors.primary,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 18,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: state.latencyHistory.map((val) {
                                  final double h = (val / 100).clamp(0.1, 1.0);
                                  return Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 1.5),
                                      height: 18 * h,
                                      decoration: BoxDecoration(
                                        color: theme.colors.primary.withValues(alpha: 0.7),
                                        borderRadius: BorderRadius.circular(1.5),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Lower section: Left column (Pool & Sliders), Right column (Terminal)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Infrastructure Controls
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          // Connection pool panel
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: theme.colors.surface,
                              borderRadius: BorderRadius.circular(theme.radiusMd),
                              border: Border.all(color: theme.colors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(LucideIcons.database, color: theme.colors.primary, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      'DB Connection Pool Status',
                                      style: theme.typography.h4.copyWith(
                                        color: theme.colors.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _PoolStat(label: 'Active Threads', value: '${state.activeConnections}'),
                                    _PoolStat(label: 'Idle Roster', value: '${state.idleConnections}'),
                                    _PoolStat(label: 'Max Threshold', value: '${state.maxConnections}'),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Visual Pool Stacked Indicator
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    height: 12,
                                    width: double.infinity,
                                    color: theme.colors.border,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: state.activeConnections,
                                          child: Container(color: theme.colors.primary),
                                        ),
                                        Flexible(
                                          flex: state.idleConnections,
                                          child: Container(color: theme.colors.primary.withValues(alpha: 0.3)),
                                        ),
                                        Flexible(
                                          flex: (state.maxConnections - state.activeConnections - state.idleConnections).clamp(0, 100),
                                          child: Container(color: Colors.transparent),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => controller.adjustConnections(5),
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(theme.radiusMd),
                                          ),
                                        ),
                                        child: const Text('Add +5 Threads'),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => controller.adjustConnections(-5),
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(theme.radiusMd),
                                          ),
                                        ),
                                        child: const Text('Release -5 Threads'),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Server Load Resource Sliders
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: theme.colors.surface,
                              borderRadius: BorderRadius.circular(theme.radiusMd),
                              border: Border.all(color: theme.colors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(LucideIcons.sliders, color: theme.colors.primary, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Simulate Resource Spikes',
                                      style: theme.typography.h4.copyWith(
                                        color: theme.colors.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Adjust sliders below to test automated scaling policies, alarms, and response logic.',
                                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('CPU Overrides'),
                                    Text('${state.cpuUsage}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Slider(
                                  value: state.cpuUsage,
                                  min: 0.0,
                                  max: 100.0,
                                  activeColor: theme.colors.primary,
                                  onChanged: controller.updateCpuUsage,
                                  onChangeEnd: (_) => controller.simulateLoadAdjust(),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Memory Pool Reserve'),
                                    Text('${state.memoryUsage}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Slider(
                                  value: state.memoryUsage,
                                  min: 0.0,
                                  max: 100.0,
                                  activeColor: theme.colors.primary,
                                  onChanged: controller.updateMemoryUsage,
                                  onChangeEnd: (_) => controller.simulateLoadAdjust(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Disaster Recovery Module
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: theme.colors.surface,
                              borderRadius: BorderRadius.circular(theme.radiusMd),
                              border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(LucideIcons.alertOctagon, color: Colors.red, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Disaster Recovery Console',
                                      style: theme.typography.h4.copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'A graceful cluster restart terminates idle thread sockets and compacts active storage caches.',
                                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton.icon(
                                    onPressed: controller.triggerReboot,
                                    icon: const Icon(LucideIcons.refreshCw, color: Colors.white),
                                    label: const Text(
                                      'Safe System Reboot',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(theme.radiusMd),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Diagnostic Logs Terminal View
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 565,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          border: Border.all(color: const Color(0xFF334155)),
                        ),
                        child: Column(
                          children: [
                            // Terminal Header
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: const BoxDecoration(
                                color: Color(0xFF1E293B),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                  ),
                                  const SizedBox(width: 16),
                                  const Icon(LucideIcons.terminal, color: Color(0xFF94A3B8), size: 16),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'diagnostics_logger_terminal.sh',
                                    style: TextStyle(
                                      color: Color(0xFFCBD5E1),
                                      fontFamily: 'Courier New',
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(LucideIcons.trash2, color: Color(0xFF94A3B8), size: 16),
                                    onPressed: controller.clearLogs,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    tooltip: 'Clear logs',
                                  )
                                ],
                              ),
                            ),
                            // Filter bar
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              color: const Color(0xFF1E293B).withValues(alpha: 0.5),
                              child: Row(
                                children: [
                                  _TerminalTabFilter(
                                    label: 'All Logs',
                                    value: 'all',
                                    activeFilter: state.activeLogLevelFilter,
                                    onTap: controller.setLogLevelFilter,
                                  ),
                                  _TerminalTabFilter(
                                    label: 'Info',
                                    value: 'info',
                                    activeFilter: state.activeLogLevelFilter,
                                    onTap: controller.setLogLevelFilter,
                                  ),
                                  _TerminalTabFilter(
                                    label: 'Warning',
                                    value: 'warning',
                                    activeFilter: state.activeLogLevelFilter,
                                    onTap: controller.setLogLevelFilter,
                                  ),
                                  _TerminalTabFilter(
                                    label: 'Error',
                                    value: 'error',
                                    activeFilter: state.activeLogLevelFilter,
                                    onTap: controller.setLogLevelFilter,
                                  ),
                                ],
                              ),
                            ),
                            // Terminal log lines list
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                width: double.infinity,
                                child: filteredLogs.isEmpty
                                    ? const Center(
                                        child: Text(
                                          'No active diagnostics stream logs present.',
                                          style: TextStyle(
                                            color: Color(0xFF64748B),
                                            fontFamily: 'Courier New',
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: filteredLogs.length,
                                        itemBuilder: (context, index) {
                                          final log = filteredLogs[index];
                                          Color fontColor = const Color(0xFFE2E8F0);
                                          if (log['level'] == 'warning') fontColor = Colors.amber.shade200;
                                          if (log['level'] == 'error') fontColor = Colors.red.shade200;

                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 6.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '[${log['timestamp']}] ',
                                                  style: const TextStyle(
                                                    color: Color(0xFF64748B),
                                                    fontFamily: 'Courier New',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  '${log['level'].toString().toUpperCase()}: ',
                                                  style: TextStyle(
                                                    color: log['level'] == 'info' 
                                                        ? const Color(0xFF38BDF8) 
                                                        : log['level'] == 'warning' 
                                                            ? Colors.amber 
                                                            : Colors.red,
                                                    fontFamily: 'Courier New',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    (log['message'] as String),
                                                    style: TextStyle(
                                                      color: fontColor,
                                                      fontFamily: 'Courier New',
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                            // Log injection triggers
                            Container(
                              padding: const EdgeInsets.all(12),
                              color: const Color(0xFF1E293B),
                              child: Row(
                                children: [
                                  const Text(
                                    'Inject Test Logs: ',
                                    style: TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontFamily: 'Courier New',
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Wrap(
                                      spacing: 8,
                                      children: [
                                        _LogTriggerButton(
                                          label: 'Warning',
                                          color: Colors.amber,
                                          onPressed: () => controller.generateTestLog(
                                            'warning',
                                            'API Gateway detected elevated request rates (Client Rate Limit Exceed).',
                                          ),
                                        ),
                                        _LogTriggerButton(
                                          label: 'Error',
                                          color: Colors.red,
                                          onPressed: () => controller.generateTestLog(
                                            'error',
                                            'Connection timed out while resolving regional caregiver roster cluster IP.',
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Pending simulation indicator
          if (state.isMutatingState)
            Container(
              color: Colors.black.withValues(alpha: 0.2),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),

          // Simulated reboot fullscreen overlay
          if (state.isRebooting)
            Container(
              color: Colors.black.withValues(alpha: 0.9),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(LucideIcons.refreshCw, color: Colors.red, size: 72),
                    const SizedBox(height: 24),
                    Text(
                      'SYSTEM REBOOT SEQUENCING',
                      style: theme.typography.h2.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Safely purging network sockets and flushing memory heaps.',
                      style: theme.typography.bodyMedium.copyWith(color: Colors.white54),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '${state.rebootCountdown}',
                      style: theme.typography.h1.copyWith(
                        color: Colors.red,
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getColorForPercent(double value) {
    if (value < 60) return Colors.green;
    if (value < 85) return Colors.amber;
    return Colors.red;
  }

  int _calculateAvgLatency(List<int> history) {
    if (history.isEmpty) return 0;
    return history.reduce((a, b) => a + b) ~/ history.length;
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Widget child;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.typography.h2.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _PoolStat extends StatelessWidget {
  final String label;
  final String value;

  const _PoolStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: 11),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _TerminalTabFilter extends StatelessWidget {
  final String label;
  final String value;
  final String activeFilter;
  final ValueChanged<String> onTap;

  const _TerminalTabFilter({
    required this.label,
    required this.value,
    required this.activeFilter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = value == activeFilter;

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF334155) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isActive ? const Color(0xFF475569) : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFFF8FAFC) : const Color(0xFF94A3B8),
            fontFamily: 'Courier New',
            fontSize: 11,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _LogTriggerButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _LogTriggerButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontFamily: 'Courier New',
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
