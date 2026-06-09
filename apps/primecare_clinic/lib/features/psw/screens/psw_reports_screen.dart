// Governance - Category: view | Purpose: UI Screen component rendering the Psw Reports workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class PswReportsState {
  final List<Map<String, String>> reports;
  final bool generating;

  const PswReportsState({
    required this.reports,
    required this.generating,
  });

  PswReportsState copyWith({
    List<Map<String, String>>? reports,
    bool? generating,
  }) {
    return PswReportsState(
      reports: reports ?? this.reports,
      generating: generating ?? this.generating,
    );
  }
}

// --- Controller ---
class PswReportsController extends StateNotifier<PswReportsState> {
  final Ref _ref;
  PswReportsController(this._ref)
      : super(const PswReportsState(
          generating: false,
          reports: [
            {'id': 'R-203', 'title': 'Arthur Pendelton ADL Log', 'date': '2026-06-05', 'status': 'Approved'},
            {'id': 'R-202', 'title': 'Margaret Thompson Bathing Note', 'date': '2026-06-04', 'status': 'Approved'},
            {'id': 'R-201', 'title': 'Incident Report - Refusal', 'date': '2026-06-03', 'status': 'Pending Review'},
          ],
        ));

  void generateNewReport() {
    state = state.copyWith(generating: true);
    Future.delayed(const Duration(milliseconds: 1000), () {
      final updated = [
        {'id': 'R-204', 'title': 'New Incident Log (Today)', 'date': '2026-06-06', 'status': 'Pending Review'},
        ...state.reports,
      ];
      state = state.copyWith(generating: false, reports: updated);
      
      try {
        _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
          route: '/psw/reports',
          eventType: 'generateNewReport',
          metadata: {'id': 'R-204'},
        );
      } catch (_) {}
    });
  }

  void submitFeedback() {
    print('Governance action: submitFeedback executed.');
  }
}

final pswReportsControllerProvider = StateNotifierProvider<PswReportsController, PswReportsState>((ref) {
  return PswReportsController(ref);
});

// --- View ---
class PswReportsScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Psw Reports screen requires components for displaying reports, analyzing data trends, and user feedback, along with responsive design across multiple platforms.';

  @override
  List<String> get requiredComponents => const [
        'ReportList',
        'DataTrendChart',
        'FeedbackSection',
        'PerformanceMetrics',
      ];

  @override
  List<String> get requiredFunctions => const [
        'loadReports',
        'analyzeData',
        'generateNewReport',
        'submitFeedback',
      ];

  const PswReportsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(pswReportsControllerProvider);
    final controller = ref.read(pswReportsControllerProvider.notifier);

    return Semantics(
      label: 'data-cy:pswreports-btn-generate',
      container: true,
      child: Scaffold(
        key: const Key('pswreports-btn-generate'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            'Shift Reports',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswreports-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('pswreports-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Analytical Metric
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Reports Generated', style: theme.typography.bodySmall),
                          Text('${state.reports.length}', style: theme.typography.h2.copyWith(color: theme.colors.primary, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: state.generating ? null : () => controller.generateNewReport(),
                        child: state.generating 
                            ? const CircularProgressIndicator(color: Colors.white) 
                            : const Text('Generate New'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Reports Log List
                Text('Active Reports Log', style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ...state.reports.map((r) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusSm),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r['title'] ?? '', style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                          Text('Created on ${r['date']}', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: (r['status'] == 'Approved') 
                              ? Colors.green.withValues(alpha: 0.1) 
                              : Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          r['status'] ?? '',
                          style: TextStyle(
                            color: (r['status'] == 'Approved') ? Colors.green : Colors.orange,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
