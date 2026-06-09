// Governance - Category: view | Purpose: UI Screen component rendering the Psw System Logs workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class PswSystemLogsState {
  final List<Map<String, String>> logs;
  final String filter;

  const PswSystemLogsState({
    required this.logs,
    required this.filter,
  });

  PswSystemLogsState copyWith({
    List<Map<String, String>>? logs,
    String? filter,
  }) {
    return PswSystemLogsState(
      logs: logs ?? this.logs,
      filter: filter ?? this.filter,
      );
  }
}

// --- Controller ---
class PswSystemLogsController extends StateNotifier<PswSystemLogsState> {
  final Ref _ref;
  PswSystemLogsController(this._ref)
      : super(const PswSystemLogsState(
          filter: 'All',
          logs: [
            {'time': '09:30:15', 'level': 'INFO', 'msg': 'Sync with central care plan registry completed.'},
            {'time': '09:28:44', 'level': 'WARN', 'msg': 'Latency shift (350ms) detected in location syncing.'},
            {'time': '09:00:01', 'level': 'INFO', 'msg': 'Shift initialization - Jane Doe checked in.'},
          ],
        ));

  void setFilter(String level) {
    state = state.copyWith(filter: level);
  }

  void exportLogs() {
    print('Governance action: exportLogs executed.');
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/system/logs',
        eventType: 'exportLogs',
        metadata: {'format': 'CSV'},
      );
    } catch (_) {}
  }

  void reportCriticalIssue() {
    print('Governance action: reportCriticalIssue executed.');
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/system/logs',
        eventType: 'reportCriticalIssue',
        metadata: {'severity': 'high'},
      );
    } catch (_) {}
  }
}

final pswSystemLogsControllerProvider = StateNotifierProvider<PswSystemLogsController, PswSystemLogsState>((ref) {
  return PswSystemLogsController(ref);
});

// --- View ---
class PswSystemLogsScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Psw System Logs screen requires components for viewing, filtering, and exporting logs, along with functionality for reporting issues and visual indicators for anomalies.';

  @override
  List<String> get requiredComponents => const [
        'LogList',
        'LogFilter',
        'LogExport',
        'LogSummary',
        'LogSearch',
        'RedFlagIndicator',
      ];

  @override
  List<String> get requiredFunctions => const [
        'filterLogs',
        'exportLogs',
        'searchLogs',
        'reportCriticalIssue',
      ];

  const PswSystemLogsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(pswSystemLogsControllerProvider);
    final controller = ref.read(pswSystemLogsControllerProvider.notifier);

    final filteredLogs = state.logs
        .where((l) => state.filter == 'All' || l['level'] == state.filter)
        .toList();

    return Semantics(
      label: 'data-cy:pswlogs-btn-export',
      container: true,
      child: Scaffold(
        key: const Key('pswlogs-btn-export'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            'System Activity Logs',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswsystemlogs-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('pswsystemlogs-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Export and controls Panel
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        key: const Key('pswlogs-btn-report'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        icon: const Icon(LucideIcons.alertTriangle, color: Colors.white, size: 14),
                        label: const Text('Report Issue', style: TextStyle(color: Colors.white)),
                        onPressed: () => controller.reportCriticalIssue(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(LucideIcons.download, size: 14),
                        label: const Text('Export Logs'),
                        onPressed: () => controller.exportLogs(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Filters
                Row(
                  children: ['All', 'INFO', 'WARN'].map((lvl) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(lvl),
                      selected: state.filter == lvl,
                      onSelected: (selected) {
                        if (selected) controller.setFilter(lvl);
                      },
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 16),

                // Logs Terminal list
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: filteredLogs.map((l) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(fontFamily: 'Courier', fontSize: 11),
                          children: [
                            TextSpan(text: '[${l['time']}] ', style: const TextStyle(color: Colors.grey)),
                            TextSpan(
                              text: '${l['level']} ',
                              style: TextStyle(
                                color: l['level'] == 'WARN' ? Colors.orange : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: l['msg'] ?? '', style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
