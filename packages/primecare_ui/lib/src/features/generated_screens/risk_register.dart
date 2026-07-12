import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Governance - Category: service | Purpose: Core implementation file for the Risk Register platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- Domain Entity ---
class OperationalRisk {
  final String id;
  final String title;
  final int probability; // 1 to 5
  final int severity; // 1 to 5
  final String mitigationPlan;
  final String status; // Active, Mitigated
  final String owner;

  const OperationalRisk({
    required this.id,
    required this.title,
    required this.probability,
    required this.severity,
    required this.mitigationPlan,
    required this.status,
    required this.owner,
  });

  int get score => probability * severity;

  OperationalRisk copyWith({String? status}) {
    return OperationalRisk(
      id: id,
      title: title,
      probability: probability,
      severity: severity,
      mitigationPlan: mitigationPlan,
      status: status ?? this.status,
      owner: owner,
    );
  }
}

// --- State Model ---
class RiskRegisterState {
  final bool isLoading;
  final List<OperationalRisk> risks;
  final int? selectedProbability;
  final int? selectedSeverity;

  const RiskRegisterState({
    required this.isLoading,
    required this.risks,
    this.selectedProbability,
    this.selectedSeverity,
  });

  RiskRegisterState copyWith({
    bool? isLoading,
    List<OperationalRisk>? risks,
    int? selectedProbability,
    int? selectedSeverity,
    bool clearFilter = false,
  }) {
    return RiskRegisterState(
      isLoading: isLoading ?? this.isLoading,
      risks: risks ?? this.risks,
      selectedProbability: clearFilter ? null : (selectedProbability ?? this.selectedProbability),
      selectedSeverity: clearFilter ? null : (selectedSeverity ?? this.selectedSeverity),
    );
  }
}

// --- Controller (Notifier) ---
class RiskRegisterController extends StateNotifier<RiskRegisterState> {
  final Ref ref;
  RiskRegisterController()
      : super(
          const RiskRegisterState(
            isLoading: false,
            risks: [
              OperationalRisk(
                id: 'RSK-302',
                title: 'Data leakage due to unencrypted cached clinical charts',
                probability: 3,
                severity: 5,
                mitigationPlan: 'Force clear database cache on background app suspend and mandate TLS 1.3.',
                status: 'Active',
                owner: 'Security Engineer',
              ),
              OperationalRisk(
                id: 'RSK-303',
                title: 'Scheduling mismatch during high-traffic clinical shifts',
                probability: 4,
                severity: 3,
                mitigationPlan: 'Introduce auto-assignment dispatch priority engine to waitlisted clients.',
                status: 'Active',
                owner: 'Intake Coordinator',
              ),
              OperationalRisk(
                id: 'RSK-304',
                title: 'Caregiver clock-in geofence bypass fraud',
                probability: 2,
                severity: 4,
                mitigationPlan: 'Implement GPS audited check-ins with immediate telemetry integrity validation gates.',
                status: 'Mitigated',
                owner: 'Product Manager',
              ),
              OperationalRisk(
                id: 'RSK-305',
                title: 'Offline database sync race conditions',
                probability: 2,
                severity: 3,
                mitigationPlan: 'Implement transaction locks and local version counters for critical ADL checklist logs.',
                status: 'Active',
                owner: 'Lead Software Architect',
              ),
            ],
          ),
        );

  void selectCell(int p, int s) {
    if (state.selectedProbability == p && state.selectedSeverity == s) {
      state = state.copyWith(clearFilter: true);
    } else {
      state = state.copyWith(
        selectedProbability: p,
        selectedSeverity: s,
      );
    }
  }

  void resetFilter() {
    state = state.copyWith(clearFilter: true);
  }

  void toggleMitigation(String id) {
    state = state.copyWith(
      risks: state.risks.map((risk) {
        if (risk.id == id) {
          final nextStatus = risk.status == 'Active' ? 'Mitigated' : 'Active';
          return risk.copyWith(status: nextStatus);
        }
        return risk;
      }).toList(),
    );
  }
}

// --- Provider ---
final riskRegisterProvider =
    StateNotifierProvider<RiskRegisterController, RiskRegisterState>((ref) {
  return RiskRegisterController(ref);
});

// --- View ---
class RiskRegister extends GovernedConsumerWidget {
  const RiskRegister({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(riskRegisterProvider);
    final controller = ref.read(riskRegisterProvider.notifier);
    final theme = context.theme;

    // Filtered risks
    final isFiltered = state.selectedProbability != null && state.selectedSeverity != null;
    final displayedRisks = state.risks.where((r) {
      if (!isFiltered) return true;
      return r.probability == state.selectedProbability && r.severity == state.selectedSeverity;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: 'Operational Risk Register',
              roleName: 'Governance Risk Oversight',
              description: 'Assess enterprise operational vulnerabilities, view active mitigation workflows, and filter risks dynamically using the heat-map matrix.',
              onRefresh: () {},
            ),
            const SizedBox(height: 24),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 5x5 Heat Matrix Grid Panel
                Expanded(
                  flex: 3,
                  child: Container(
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
                              'Risk Assessment Heat-Matrix (5x5)',
                              style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                            ),
                            if (isFiltered)
                              TextButton.icon(
                                icon: const Icon(LucideIcons.x, size: 16),
                                label: const Text('Reset Filter'),
                                onPressed: controller.resetFilter,
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Layout Y axis Probability (5 down to 1), X axis Severity (1 to 5)
                        Row(
                          children: [
                            // Y-axis label
                            const RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                'PROBABILITY (LOCKED 1-5)',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1.5),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Grid
                            Expanded(
                              child: Column(
                                children: List.generate(5, (yIdx) {
                                  final pVal = 5 - yIdx; // 5 down to 1
                                  return Row(
                                    children: List.generate(5, (xIdx) {
                                      final sVal = xIdx + 1; // 1 to 5
                                      final cellScore = pVal * sVal;

                                      // Get number of risks in this coordinate
                                      final count = state.risks.where((r) => r.probability == pVal && r.severity == sVal).length;

                                      // Style color zones based on score
                                      Color cellColor = Colors.green.shade600;
                                      if (cellScore >= 15) {
                                        cellColor = Colors.red.shade700;
                                      } else if (cellScore >= 8) {
                                        cellColor = Colors.orange.shade600;
                                      }

                                      final isSelectedCell = state.selectedProbability == pVal && state.selectedSeverity == sVal;

                                      return Expanded(
                                        child: InkWell(
                                          onTap: () => controller.selectCell(pVal, sVal),
                                          child: Container(
                                            height: 52,
                                            margin: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: cellColor.withOpacity(isSelectedCell ? 0.95 : 0.25),
                                              border: Border.all(
                                                color: isSelectedCell ? theme.colors.primary : cellColor.withOpacity(0.5),
                                                width: isSelectedCell ? 2.5 : 1,
                                              ),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              count > 0 ? '$count Active' : '$cellScore',
                                              style: TextStyle(
                                                color: isSelectedCell ? Colors.white : cellColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // X-axis label
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(width: 32),
                            Text(
                              'SEVERITY IMPACT (LOCKED 1-5)',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1.5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // Risk Directory List
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isFiltered
                              ? 'Vulnerabilities at (P:$state.selectedProbability, S:$state.selectedSeverity)'
                              : 'Vulnerabilities Directory (${displayedRisks.length})',
                          style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 16),
                        if (displayedRisks.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Center(
                              child: Text(
                                'No registered risks in this coordinate.',
                                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: displayedRisks.length,
                            itemBuilder: (context, index) {
                              final risk = displayedRisks[index];
                              final isCritical = risk.score >= 15;
                              final isWarning = risk.score >= 8 && risk.score < 15;

                              Color statusColor = Colors.green;
                              if (isCritical) statusColor = Colors.red;
                              else if (isWarning) statusColor = Colors.orange;

                              final isMitigated = risk.status == 'Mitigated';

                              return Card(
                                color: theme.colors.background,
                                margin: const EdgeInsets.only(bottom: 12),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(theme.radiusSm),
                                  side: BorderSide(color: theme.colors.border),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: statusColor.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  'Score: ${risk.score}',
                                                  style: TextStyle(
                                                    color: statusColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                risk.id,
                                                style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          ChoiceChip(
                                            label: Text(
                                              risk.status,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: isMitigated ? Colors.green : Colors.red,
                                              ),
                                            ),
                                            selected: isMitigated,
                                            selectedColor: Colors.green.withOpacity(0.15),
                                            backgroundColor: Colors.red.withOpacity(0.15),
                                            onSelected: (val) {
                                              controller.toggleMitigation(risk.id);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Mitigation status updated for ${risk.id}.'),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        risk.title,
                                        style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Mitigation: ${risk.mitigationPlan}',
                                        style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(LucideIcons.user, size: 12),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Owner: ${risk.owner}',
                                            style: theme.typography.labelSmall.copyWith(color: theme.colors.onSurfaceVariant),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
