// Governance - Category: view | Purpose: --- MVC State Model ---
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class RpnAnalyticsState {
  final List<Map<String, dynamic>> woundAssessments;
  final Map<String, double> immunizationStatus;
  final int woundCases;
  final double vitalsCompliance;
  final int totalImmunizations;

  const RpnAnalyticsState({
    required this.woundAssessments,
    required this.immunizationStatus,
    required this.woundCases,
    required this.vitalsCompliance,
    required this.totalImmunizations,
  });

  RpnAnalyticsState copyWith({
    List<Map<String, dynamic>>? woundAssessments,
    Map<String, double>? immunizationStatus,
    int? woundCases,
    double? vitalsCompliance,
    int? totalImmunizations,
  }) {
    return RpnAnalyticsState(
      woundAssessments: woundAssessments ?? this.woundAssessments,
      immunizationStatus: immunizationStatus ?? this.immunizationStatus,
      woundCases: woundCases ?? this.woundCases,
      vitalsCompliance: vitalsCompliance ?? this.vitalsCompliance,
      totalImmunizations: totalImmunizations ?? this.totalImmunizations,
    );
  }
}

// --- Controller ---
class RpnAnalyticsController extends StateNotifier<RpnAnalyticsState> {
  final Ref _ref;

  RpnAnalyticsController(this._ref)
      : super(
          const RpnAnalyticsState(
            woundCases: 8,
            vitalsCompliance: 98.8,
            totalImmunizations: 42,
            immunizationStatus: {
              'Influenza Annual': 0.92,
              'COVID-19 Booster': 0.84,
              'Pneumococcal Polyvalent': 0.68,
              'Shingles Recombinant': 0.74,
            },
            woundAssessments: [
              {
                'id': 'WND-001',
                'patient': 'Margaret Thompson',
                'location': 'Sacrum',
                'stage': 'Stage 2 Pressure Injury',
                'status': 'Healing',
                'size': '3.2 x 2.1 cm',
                'lastDressed': '4 hours ago',
              },
              {
                'id': 'WND-002',
                'patient': 'Arthur Pendelton',
                'location': 'Left Heel',
                'stage': 'Stage 1 Pressure Injury',
                'status': 'Stable',
                'size': '1.0 x 1.2 cm',
                'lastDressed': '8 hours ago',
              },
              {
                'id': 'WND-003',
                'patient': 'Eleanor Vance',
                'location': 'Abdominal Incision',
                'stage': 'Post-Surgical Incision',
                'status': 'Fully Healed',
                'size': 'Closed',
                'lastDressed': '2 days ago',
              },
            ],
          ),
        );

  void updateWoundStatus(String woundId, String status, String size) {
    final updatedWounds = state.woundAssessments.map((w) {
      if (w['id'] == woundId) {
        return {
          ...w,
          'status': status,
          'size': size,
          'lastDressed': 'Just Now',
        };
      }
      return w;
    }).toList();

    state = state.copyWith(woundAssessments: updatedWounds);

    // Aura behavioral telemetry logging
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/rpn/analytics',
            eventType: 'rpn_wound_status_updated',
            metadata: {
              'woundId': woundId,
              'status': status,
              'size': size,
            },
          );
    } catch (_) {}
  }
}

// --- Provider ---
final rpnAnalyticsControllerProvider =
    StateNotifierProvider<RpnAnalyticsController, RpnAnalyticsState>((ref) {
  return RpnAnalyticsController(ref);
});

// --- View ---
class RpnAnalyticsScreen extends GovernedConsumerWidget {
  const RpnAnalyticsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpnAnalyticsControllerProvider);
    final controller = ref.read(rpnAnalyticsControllerProvider.notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'RPN Clinical Insights',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: 'Wound Assessments & Immunizations',
              roleName: 'Registered Practical Nurse (RPN)',
              description:
                  'Practical clinical execution dashboards tracking localized wound status metrics and regional vaccination coverage.',
              onRefresh: () => ref.refresh(rpnAnalyticsControllerProvider),
            ),
            const SizedBox(height: 24),

            // Metrics Grid
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
                      title: 'Active Wound Cases',
                      value: state.woundCases.toString(),
                      icon: LucideIcons.activity,
                      color: Colors.red,
                    ),
                    PrimeCareKpiCard(
                      title: 'Vitals Logging Rate',
                      value: '${state.vitalsCompliance.toStringAsFixed(1)}%',
                      icon: LucideIcons.heartHandshake,
                      color: Colors.green,
                    ),
                    PrimeCareKpiCard(
                      title: 'Immunizations Managed',
                      value: state.totalImmunizations.toString(),
                      icon: LucideIcons.shieldAlert,
                      color: Colors.blue,
                    ),
                    PrimeCareKpiCard(
                      title: 'Target Compliance',
                      value: '100%',
                      icon: LucideIcons.badgeCheck,
                      color: theme.colors.primary,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            // Responsive Two Columns (Wound assessments table vs Immunization coverage progress)
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 900) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: _buildWoundsLedgerCard(context, state, controller),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 4,
                        child: _buildImmunizationProgressCard(context, state),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildWoundsLedgerCard(context, state, controller),
                      const SizedBox(height: 24),
                      _buildImmunizationProgressCard(context, state),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWoundsLedgerCard(
    BuildContext context,
    RpnAnalyticsState state,
    RpnAnalyticsController controller,
  ) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Wound Care Assessment Ledger',
            style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Track pressure injury stages, dimensions, and localized dressing replacement intervals.',
            style: theme.typography.bodyMedium.copyWith(
              color: theme.colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 24,
              columns: [
                DataColumn(
                  label: Text('Patient Name', style: theme.typography.labelBold),
                ),
                DataColumn(
                  label: Text('Location', style: theme.typography.labelBold),
                ),
                DataColumn(
                  label: Text('Stage/Category', style: theme.typography.labelBold),
                ),
                DataColumn(
                  label: Text('Status', style: theme.typography.labelBold),
                ),
                DataColumn(
                  label: Text('Dimensions', style: theme.typography.labelBold),
                ),
                DataColumn(
                  label: Text('Dressing Age', style: theme.typography.labelBold),
                ),
                DataColumn(
                  label: Text('Update', style: theme.typography.labelBold),
                ),
              ],
              rows: state.woundAssessments.map((w) {
                final id = w['id'] as String;
                final patient = w['patient'] as String;
                final location = w['location'] as String;
                final stage = w['stage'] as String;
                final status = w['status'] as String;
                final size = w['size'] as String;
                final lastDressed = w['lastDressed'] as String;

                final isHealing = status == 'Healing';
                final isHealed = status == 'Fully Healed';

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
                    DataCell(Text(location, style: theme.typography.bodyMedium)),
                    DataCell(Text(stage, style: theme.typography.bodyMedium)),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isHealed
                              ? Colors.green.withValues(alpha: 0.1)
                              : isHealing
                                  ? Colors.blue.withValues(alpha: 0.1)
                                  : Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          status,
                          style: theme.typography.labelSmall.copyWith(
                            color: isHealed
                                ? Colors.green
                                : isHealing
                                    ? Colors.blue
                                    : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(size, style: theme.typography.bodyMedium)),
                    DataCell(
                      Text(
                        lastDressed,
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(LucideIcons.edit2,
                            color: theme.colors.primary, size: 16),
                        onPressed: () {
                          _showWoundEditDialog(
                              context, id, status, size, patient, controller);
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

  Widget _buildImmunizationProgressCard(
    BuildContext context,
    RpnAnalyticsState state,
  ) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Immunization Rates',
            style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Roster vaccine coverage metrics and completed preventative logs.',
            style: theme.typography.bodyMedium.copyWith(
              color: theme.colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          ...state.immunizationStatus.entries.map((entry) {
            final double value = entry.value;
            final String label = entry.key;

            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: theme.typography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${(value * 100).toInt()}%',
                        style: theme.typography.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 8,
                      backgroundColor: theme.colors.divider,
                      valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showWoundEditDialog(
    BuildContext context,
    String woundId,
    String currentStatus,
    String currentSize,
    String patientName,
    RpnAnalyticsController controller,
  ) {
    final theme = context.theme;
    final sizeController = TextEditingController(text: currentSize);
    String selectedStatus = currentStatus;

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
              title: Text('Update Wound Assessment', style: theme.typography.h3),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    dropdownColor: theme.colors.surface,
                    style: theme.typography.bodyMedium.copyWith(
                      color: theme.colors.onSurface,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Assessment Status',
                      labelStyle: theme.typography.labelMedium,
                    ),
                    items: ['Healing', 'Stable', 'Deteriorating', 'Fully Healed']
                        .map(
                          (s) => DropdownMenuItem(value: s, child: Text(s)),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          selectedStatus = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: sizeController,
                    style: theme.typography.bodyMedium,
                    decoration: InputDecoration(
                      labelText: 'Dressing Dimensions (cm)',
                      labelStyle: theme.typography.labelMedium,
                      hintText: 'e.g. 2.4 x 1.8 cm...',
                    ),
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
                    controller.updateWoundStatus(
                      woundId,
                      selectedStatus,
                      sizeController.text,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Update Ledger'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
