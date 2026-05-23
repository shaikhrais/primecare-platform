// Governance - Category: view | Purpose: --- MVC State Model ---
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class RnAnalyticsState {
  final String selectedCategory; // 'All', 'Escalated', 'Pending'
  final List<Map<String, dynamic>> evaluations;
  final int completedIntakes;
  final int activeCarePlans;
  final int escalatedAlerts;
  final double averageMmseScore;

  const RnAnalyticsState({
    required this.selectedCategory,
    required this.evaluations,
    required this.completedIntakes,
    required this.activeCarePlans,
    required this.escalatedAlerts,
    required this.averageMmseScore,
  });

  RnAnalyticsState copyWith({
    String? selectedCategory,
    List<Map<String, dynamic>>? evaluations,
    int? completedIntakes,
    int? activeCarePlans,
    int? escalatedAlerts,
    double? averageMmseScore,
  }) {
    return RnAnalyticsState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      evaluations: evaluations ?? this.evaluations,
      completedIntakes: completedIntakes ?? this.completedIntakes,
      activeCarePlans: activeCarePlans ?? this.activeCarePlans,
      escalatedAlerts: escalatedAlerts ?? this.escalatedAlerts,
      averageMmseScore: averageMmseScore ?? this.averageMmseScore,
    );
  }
}

// --- Controller ---
class RnAnalyticsController extends StateNotifier<RnAnalyticsState> {
  final Ref _ref;

  RnAnalyticsController(this._ref)
      : super(
          const RnAnalyticsState(
            selectedCategory: 'All',
            completedIntakes: 14,
            activeCarePlans: 38,
            escalatedAlerts: 3,
            averageMmseScore: 24.8,
            evaluations: [
              {
                'id': 'EVAL-001',
                'patient': 'Margaret Thompson',
                'mmse': 26,
                'status': 'Mild Cognitive Decline',
                'isEscalated': false,
                'lastTested': '2 weeks ago',
              },
              {
                'id': 'EVAL-002',
                'patient': 'Arthur Pendelton',
                'mmse': 18,
                'status': 'Moderate Cognitive Decline',
                'isEscalated': true,
                'lastTested': '1 week ago',
              },
              {
                'id': 'EVAL-003',
                'patient': 'Eleanor Vance',
                'mmse': 29,
                'status': 'Normal Cognitive Function',
                'isEscalated': false,
                'lastTested': '3 days ago',
              },
              {
                'id': 'EVAL-004',
                'patient': 'Douglas Miller',
                'mmse': 12,
                'status': 'Severe Cognitive Decline',
                'isEscalated': true,
                'lastTested': 'Yesterday',
              },
              {
                'id': 'EVAL-005',
                'patient': 'Beatrice Myers',
                'mmse': 24,
                'status': 'Mild Cognitive Decline',
                'isEscalated': false,
                'lastTested': '1 month ago',
              },
            ],
          ),
        );

  void changeCategory(String category) {
    state = state.copyWith(selectedCategory: category);

    // Aura behavioral telemetry log
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/rn/analytics',
            eventType: 'rn_analytics_category_changed',
            metadata: {'category': category},
          );
    } catch (_) {}
  }

  void updateMmseScore(String evalId, int newMmse) {
    String determineStatus(int mmse) {
      if (mmse >= 25) return 'Normal Cognitive Function';
      if (mmse >= 20) return 'Mild Cognitive Decline';
      if (mmse >= 13) return 'Moderate Cognitive Decline';
      return 'Severe Cognitive Decline';
    }

    final updatedEvals = state.evaluations.map((e) {
      if (e['id'] == evalId) {
        final status = determineStatus(newMmse);
        return {
          ...e,
          'mmse': newMmse,
          'status': status,
          'isEscalated': newMmse < 20,
        };
      }
      return e;
    }).toList();

    // Recompute averages
    final total = updatedEvals.fold<int>(0, (sum, item) => sum + (item['mmse'] as int));
    final avg = total / updatedEvals.length;
    final escCount = updatedEvals.where((item) => item['isEscalated'] == true).length;

    state = state.copyWith(
      evaluations: updatedEvals,
      averageMmseScore: avg,
      escalatedAlerts: escCount,
    );

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/rn/analytics',
            eventType: 'rn_mmse_score_modified',
            metadata: {'evalId': evalId, 'mmse': newMmse},
          );
    } catch (_) {}
  }
}

// --- Provider ---
final rnAnalyticsControllerProvider =
    StateNotifierProvider<RnAnalyticsController, RnAnalyticsState>((ref) {
  return RnAnalyticsController(ref);
});

// --- View ---
class RnAnalyticsScreen extends GovernedConsumerWidget {
  const RnAnalyticsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rnAnalyticsControllerProvider);
    final controller = ref.read(rnAnalyticsControllerProvider.notifier);
    final theme = context.theme;

    // Filter evaluations
    final displayEvaluations = state.evaluations.where((e) {
      if (state.selectedCategory == 'All') return true;
      if (state.selectedCategory == 'Escalated') return e['isEscalated'] == true;
      return e['isEscalated'] != true; // Normal/Mild
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'RN Clinical Insights',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: 'Cognitive Scoring & Care Parity',
              roleName: 'Registered Nurse (RN) Lead',
              description:
                  'Supervisory oversight dashboard analyzing MMSE cognitive tracking indices and incident telemetry.',
              onRefresh: () => ref.refresh(rnAnalyticsControllerProvider),
            ),
            const SizedBox(height: 24),

            // RN Supervisory KPI Widgets
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 900 ? 4 : 2;
                return GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  children: [
                    PrimeCareKpiCard(
                      title: 'Avg Patient MMSE',
                      value: '${state.averageMmseScore.toStringAsFixed(1)} / 30',
                      icon: LucideIcons.brain,
                      color: Colors.blue,
                    ),
                    PrimeCareKpiCard(
                      title: 'Completed Intakes',
                      value: state.completedIntakes.toString(),
                      icon: LucideIcons.clipboardCheck,
                      color: theme.colors.primary,
                    ),
                    PrimeCareKpiCard(
                      title: 'Active Care Plans',
                      value: state.activeCarePlans.toString(),
                      icon: LucideIcons.fileSpreadsheet,
                      color: Colors.green,
                    ),
                    PrimeCareKpiCard(
                      title: 'High Risk Escalations',
                      value: state.escalatedAlerts.toString(),
                      icon: LucideIcons.bellRing,
                      color: theme.colors.error,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            // Tab Filters
            Row(
              children: ['All', 'Escalated', 'Stable'].map((cat) {
                final isSelected = state.selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: theme.colors.primary.withValues(alpha: 0.15),
                    labelStyle: theme.typography.bodyMedium.copyWith(
                      color: isSelected
                          ? theme.colors.primary
                          : theme.colors.onSurfaceVariant,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (val) {
                      if (val) controller.changeCategory(cat);
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // High Fidelity Table for Cognitive Evaluations (MMSE)
            _buildCognitiveTableCard(context, displayEvaluations, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildCognitiveTableCard(
    BuildContext context,
    List<Map<String, dynamic>> displayEvaluations,
    RnAnalyticsController controller,
  ) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mini-Mental State Examination (MMSE) Ledger',
            style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Interactive logs tracking cognitive impairment rates, diagnostic categories, and latest evaluation histories.',
            style: theme.typography.bodyMedium.copyWith(
              color: theme.colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 32,
              columns: [
                DataColumn(
                  label: Text(
                    'Patient Name',
                    style: theme.typography.labelBold.copyWith(
                      color: theme.colors.onSurface,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'MMSE Score',
                    style: theme.typography.labelBold.copyWith(
                      color: theme.colors.onSurface,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Cognitive Category',
                    style: theme.typography.labelBold.copyWith(
                      color: theme.colors.onSurface,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Incident Level',
                    style: theme.typography.labelBold.copyWith(
                      color: theme.colors.onSurface,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Assessment History',
                    style: theme.typography.labelBold.copyWith(
                      color: theme.colors.onSurface,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Modify Score',
                    style: theme.typography.labelBold.copyWith(
                      color: theme.colors.onSurface,
                    ),
                  ),
                ),
              ],
              rows: displayEvaluations.map((eval) {
                final id = eval['id'] as String;
                final patient = eval['patient'] as String;
                final mmse = eval['mmse'] as int;
                final status = eval['status'] as String;
                final isEsc = eval['isEscalated'] as bool;
                final lastTested = eval['lastTested'] as String;

                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        patient,
                        style: theme.typography.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isEsc
                              ? theme.colors.error.withValues(alpha: 0.1)
                              : Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '$mmse / 30',
                          style: TextStyle(
                            color: isEsc ? theme.colors.error : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        status,
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurface,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        isEsc ? '🔴 Escalated Critical' : '🟢 Stable Standard',
                        style: theme.typography.bodyMedium.copyWith(
                          color: isEsc ? theme.colors.error : Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        lastTested,
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(LucideIcons.edit2, color: theme.colors.primary, size: 18),
                        onPressed: () {
                          _showScoreEditDialog(context, id, mmse, patient, controller);
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showScoreEditDialog(
    BuildContext context,
    String evalId,
    int currentScore,
    String patientName,
    RnAnalyticsController controller,
  ) {
    final theme = context.theme;
    double sliderValue = currentScore.toDouble();

    showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: theme.colors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text('Modify MMSE Score', style: theme.typography.h3),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adjust patient cognitive score for $patientName:',
                    style: theme.typography.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Impaired', style: theme.typography.bodySmall),
                      Text(
                        '${sliderValue.toInt()} / 30',
                        style: theme.typography.h2.copyWith(
                          color: theme.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Normal', style: theme.typography.bodySmall),
                    ],
                  ),
                  Slider(
                    value: sliderValue,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    activeColor: theme.colors.primary,
                    onChanged: (val) {
                      setState(() {
                        sliderValue = val;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: theme.colors.onSurfaceVariant),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.primary,
                    foregroundColor: theme.colors.onPrimary,
                  ),
                  onPressed: () {
                    controller.updateMmseScore(evalId, sliderValue.toInt());
                    Navigator.pop(context);
                  },
                  child: const Text('Update Score'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
