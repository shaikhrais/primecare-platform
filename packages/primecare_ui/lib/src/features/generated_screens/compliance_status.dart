// Governance - Category: service | Purpose: --- MVC State Model ---
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class ComplianceStatusState {
  final List<Map<String, dynamic>> caregiverCredentials;
  final List<Map<String, dynamic>> branchLicenses;
  final double clinicalAdlScore;
  final String statusFilter;
  final bool isMutatingState;

  const ComplianceStatusState({
    required this.caregiverCredentials,
    required this.branchLicenses,
    required this.clinicalAdlScore,
    required this.statusFilter,
    required this.isMutatingState,
  });

  ComplianceStatusState copyWith({
    List<Map<String, dynamic>>? caregiverCredentials,
    List<Map<String, dynamic>>? branchLicenses,
    double? clinicalAdlScore,
    String? statusFilter,
    bool? isMutatingState,
  }) {
    return ComplianceStatusState(
      caregiverCredentials: caregiverCredentials ?? this.caregiverCredentials,
      branchLicenses: branchLicenses ?? this.branchLicenses,
      clinicalAdlScore: clinicalAdlScore ?? this.clinicalAdlScore,
      statusFilter: statusFilter ?? this.statusFilter,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class ComplianceStatusController extends StateNotifier<ComplianceStatusState> {
  final Ref _ref;

  ComplianceStatusController(this._ref)
      : super(
          const ComplianceStatusState(
            caregiverCredentials: [
              {
                'id': 'cred-001',
                'name': 'Jane Smith',
                'credential': 'CPR Certification',
                'status': 'Compliant',
                'expiry': '2027-02-15',
              },
              {
                'id': 'cred-002',
                'name': 'David Miller',
                'credential': 'Vulnerable Sector Check',
                'status': 'Compliant',
                'expiry': '2026-12-01',
              },
              {
                'id': 'cred-003',
                'name': 'Sarah Jenkins',
                'credential': 'First Aid Level C',
                'status': 'Action Required',
                'expiry': '2026-05-10',
              },
              {
                'id': 'cred-004',
                'name': 'Michael Chang',
                'credential': 'TB Screen Test',
                'status': 'Pending',
                'expiry': '2026-06-20',
              },
              {
                'id': 'cred-005',
                'name': 'Elena Rostova',
                'credential': 'RN Nursing License',
                'status': 'Compliant',
                'expiry': '2027-08-31',
              },
            ],
            branchLicenses: [
              {
                'id': 'lic-101',
                'name': 'Toronto West Franchise License',
                'status': 'Compliant',
                'expiry': '2027-10-31',
              },
              {
                'id': 'lic-102',
                'name': 'Hamilton Central Operations Permit',
                'status': 'Compliant',
                'expiry': '2027-04-15',
              },
              {
                'id': 'lic-103',
                'name': 'London Health Agency Permit',
                'status': 'Pending',
                'expiry': '2026-07-01',
              },
            ],
            clinicalAdlScore: 0.942,
            statusFilter: 'All',
            isMutatingState: false,
          ),
        );

  void setFilter(String filter) {
    state = state.copyWith(statusFilter: filter);
  }

  void triggerComplianceAudit() {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/compliance_status',
            eventType: 'compliance_audit_triggered',
            metadata: {
              'refreshed_at': DateTime.now().toIso8601String(),
              'current_adl_score': state.clinicalAdlScore,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 500), () {
      // Simulate credential updates or checks
      final updatedCredentials = state.caregiverCredentials.map((cred) {
        if (cred['status'] == 'Pending') {
          // Verify pending items during audit
          return {
            ...cred,
            'status': 'Compliant',
          };
        }
        return cred;
      }).toList();

      final updatedLicenses = state.branchLicenses.map((lic) {
        if (lic['status'] == 'Pending') {
          return {
            ...lic,
            'status': 'Compliant',
          };
        }
        return lic;
      }).toList();

      state = state.copyWith(
        caregiverCredentials: updatedCredentials,
        branchLicenses: updatedLicenses,
        clinicalAdlScore: 0.965, // Audit improved score
        isMutatingState: false,
      );
    });
  }
}

// --- Provider ---
final complianceStatusControllerProvider =
    StateNotifierProvider<ComplianceStatusController, ComplianceStatusState>((ref) {
  return ComplianceStatusController(ref);
});

// --- View ---
class ComplianceStatus extends GovernedConsumerWidget {
  const ComplianceStatus({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(complianceStatusControllerProvider);
    final controller = ref.read(complianceStatusControllerProvider.notifier);
    final theme = context.theme;

    // Apply Filter to Credentials and Licenses
    final filteredCredentials = state.caregiverCredentials.where((cred) {
      if (state.statusFilter == 'All') return true;
      return cred['status'] == state.statusFilter;
    }).toList();

    final filteredLicenses = state.branchLicenses.where((lic) {
      if (state.statusFilter == 'All') return true;
      return lic['status'] == state.statusFilter;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.shieldCheck, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Franchise Compliance Governance Center',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: ElevatedButton.icon(
              onPressed: () => controller.triggerComplianceAudit(),
              icon: const Icon(LucideIcons.activity, size: 16),
              label: const Text('Run Compliance Audit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Corporate Operational & Credential Compliance',
                            style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Franchise Owner Monthly Auditing Ledger. Track nurse/caregiver certification expiry pools and verify ADL clinical scores.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: state.statusFilter,
                      onChanged: (val) {
                        if (val != null) controller.setFilter(val);
                      },
                      items: const [
                        DropdownMenuItem(value: 'All', child: Text('All Statuses')),
                        DropdownMenuItem(value: 'Compliant', child: Text('Compliant')),
                        DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                        DropdownMenuItem(value: 'Action Required', child: Text('Action Required')),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // KPI Summaries
                Row(
                  children: [
                    Expanded(
                      child: _ComplianceKpiCard(
                        title: 'Clinical ADL Compliance',
                        value: '${(state.clinicalAdlScore * 100).toStringAsFixed(1)}%',
                        subtitle: 'Target: 95.0% Minimum',
                        icon: LucideIcons.checkSquare,
                        iconColor: state.clinicalAdlScore >= 0.95 ? Colors.green : Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _ComplianceKpiCard(
                        title: 'Caregiver Credentials',
                        value: '${state.caregiverCredentials.where((c) => c['status'] == 'Compliant').length}/${state.caregiverCredentials.length}',
                        subtitle: 'Active staff certifications',
                        icon: LucideIcons.award,
                        iconColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _ComplianceKpiCard(
                        title: 'Branch Business Licenses',
                        value: '${state.branchLicenses.where((l) => l['status'] == 'Compliant').length}/${state.branchLicenses.length}',
                        subtitle: 'Local regulatory health permits',
                        icon: LucideIcons.building,
                        iconColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Credentials Grid/List
                Text(
                  'Caregiver Credentials Status Directory',
                  style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: filteredCredentials.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: Text(
                              'No caregiver credentials match the selected status filter.',
                              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredCredentials.length,
                          separatorBuilder: (context, index) => Divider(height: 1, color: theme.colors.border),
                          itemBuilder: (context, index) {
                            final item = filteredCredentials[index];
                            final status = item['status'] as String;
                            final statusColor = status == 'Compliant'
                                ? Colors.green
                                : status == 'Pending'
                                    ? Colors.amber
                                    : Colors.red;

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: statusColor.withValues(alpha: 0.1),
                                child: Icon(
                                  status == 'Compliant'
                                      ? LucideIcons.check
                                      : status == 'Pending'
                                          ? LucideIcons.helpCircle
                                          : LucideIcons.alertTriangle,
                                  color: statusColor,
                                  size: 20,
                                ),
                              ),
                              title: Text(
                                (item['name'] as String),
                                style: theme.typography.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colors.onSurface,
                                ),
                              ),
                              subtitle: Text('${item['credential']} • Expiring: ${item['expiry']}'),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 32),

                // Branch Licenses Status Directory
                Text(
                  'Branch Regulatory Permits & Business Licenses',
                  style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: filteredLicenses.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: Text(
                              'No branch licenses match the selected status filter.',
                              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredLicenses.length,
                          separatorBuilder: (context, index) => Divider(height: 1, color: theme.colors.border),
                          itemBuilder: (context, index) {
                            final item = filteredLicenses[index];
                            final status = item['status'] as String;
                            final statusColor = status == 'Compliant'
                                ? Colors.green
                                : status == 'Pending'
                                    ? Colors.amber
                                    : Colors.red;

                            return ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  LucideIcons.fileText,
                                  color: statusColor,
                                  size: 16,
                                ),
                              ),
                              title: Text(
                                (item['name'] as String),
                                style: theme.typography.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colors.onSurface,
                                ),
                              ),
                              subtitle: Text('Regulatory Status Ledger • Renew by: ${item['expiry']}'),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          if (state.isMutatingState)
            Container(
              color: Colors.black.withValues(alpha: 0.15),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class _ComplianceKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const _ComplianceKpiCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      color: theme.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.radiusMd),
        side: BorderSide(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: theme.typography.h2.copyWith(
                      color: theme.colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.typography.bodySmall.copyWith(
                      color: theme.colors.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
