// Governance - Category: view | Purpose: UI Screen component rendering the Billing Claims Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class BillingClaimsState {
  final List<Map<String, dynamic>> claims;
  final List<String> selectedClaimIds;
  final bool isSubmittingBatch;
  final double outstandingClaimsVal;
  final double reimbursedThisMonthVal;

  const BillingClaimsState({
    required this.claims,
    required this.selectedClaimIds,
    required this.isSubmittingBatch,
    required this.outstandingClaimsVal,
    required this.reimbursedThisMonthVal,
  });

  BillingClaimsState copyWith({
    List<Map<String, dynamic>>? claims,
    List<String>? selectedClaimIds,
    bool? isSubmittingBatch,
    double? outstandingClaimsVal,
    double? reimbursedThisMonthVal,
  }) {
    return BillingClaimsState(
      claims: claims ?? this.claims,
      selectedClaimIds: selectedClaimIds ?? this.selectedClaimIds,
      isSubmittingBatch: isSubmittingBatch ?? this.isSubmittingBatch,
      outstandingClaimsVal: outstandingClaimsVal ?? this.outstandingClaimsVal,
      reimbursedThisMonthVal: reimbursedThisMonthVal ?? this.reimbursedThisMonthVal,
    );
  }
}

// --- Controller ---
class BillingClaimsController extends StateNotifier<BillingClaimsState> {
  final Ref _ref;

  BillingClaimsController(this._ref)
      : super(
          const BillingClaimsState(
            claims: [
              {
                'id': 'clm-801',
                'client': 'Margaret Thompson',
                'insurer': 'Medicare Blue Cross',
                'claimCode': 'HCPCS-G0154',
                'amount': 350.00,
                'status': 'auditing',
                'statusText': 'In Audit',
                'date': '2026-05-10',
              },
              {
                'id': 'clm-802',
                'client': 'James Wilson',
                'insurer': 'Private SunLife Direct',
                'claimCode': 'HCPCS-T1002',
                'amount': 890.00,
                'status': 'reimbursed',
                'statusText': 'Reimbursed',
                'date': '2026-05-12',
              },
              {
                'id': 'clm-803',
                'client': 'Robert Davis',
                'insurer': 'Medicare Blue Cross',
                'claimCode': 'HCPCS-G0151',
                'amount': 240.00,
                'status': 'auditing',
                'statusText': 'In Audit',
                'date': '2026-05-15',
              },
              {
                'id': 'clm-804',
                'client': 'Patricia Garcia',
                'insurer': 'Private Manulife Care',
                'claimCode': 'HCPCS-S5125',
                'amount': 450.00,
                'status': 'rejected',
                'statusText': 'Rejected (Missing Doc)',
                'date': '2026-05-18',
              },
            ],
            selectedClaimIds: [],
            isSubmittingBatch: false,
            outstandingClaimsVal: 1040.00,
            reimbursedThisMonthVal: 14850.00,
          ),
        );

  void toggleSelectClaim(String claimId) {
    if (state.selectedClaimIds.contains(claimId)) {
      state = state.copyWith(
        selectedClaimIds: state.selectedClaimIds.where((id) => id != claimId).toList(),
      );
    } else {
      state = state.copyWith(
        selectedClaimIds: [...state.selectedClaimIds, claimId],
      );
    }
  }

  void toggleSelectAll(bool selectAll) {
    if (selectAll) {
      final auditable = state.claims
          .where((c) => c['status'] == 'auditing' || c['status'] == 'rejected')
          .map((c) => c['id'] as String)
          .toList();
      state = state.copyWith(selectedClaimIds: auditable);
    } else {
      state = state.copyWith(selectedClaimIds: const []);
    }
  }

  void submitSelectedBatch() {
    if (state.selectedClaimIds.isEmpty) return;
    state = state.copyWith(isSubmittingBatch: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/billing_claims',
            eventType: 'billing_claims_batch_submitted',
            metadata: {'claimIds': state.selectedClaimIds},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 600), () {
      double addedReimbursements = 0;
      final updatedClaims = state.claims.map((c) {
        if (state.selectedClaimIds.contains(c['id'])) {
          addedReimbursements += c['amount'] as double;
          return {
            ...c,
            'status': 'reimbursed',
            'statusText': 'Reimbursed',
          };
        }
        return c;
      }).toList();

      state = state.copyWith(
        isSubmittingBatch: false,
        selectedClaimIds: const [],
        claims: updatedClaims,
        outstandingClaimsVal: state.outstandingClaimsVal - addedReimbursements,
        reimbursedThisMonthVal: state.reimbursedThisMonthVal + addedReimbursements,
      );
    });
  }

  void manuallyReconcile(String claimId) {
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/billing_claims',
            eventType: 'billing_claims_manual_reconcile',
            metadata: {'claimId': claimId},
          );
    } catch (_) {}

    final updated = state.claims.map((c) {
      if (c['id'] == claimId) {
        return {
          ...c,
          'status': 'reimbursed',
          'statusText': 'Manually Reconciled',
        };
      }
      return c;
    }).toList();

    state = state.copyWith(claims: updated);
  }
}

// --- Provider ---
final billingClaimsControllerProvider =
    StateNotifierProvider<BillingClaimsController, BillingClaimsState>((ref) {
  return BillingClaimsController(ref);
});

// --- View ---
class BillingClaimsScreen extends GovernedConsumerWidget {
  const BillingClaimsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(billingClaimsControllerProvider);
    final controller = ref.read(billingClaimsControllerProvider.notifier);
    final theme = context.theme;

    final auditableCount = state.claims.where((c) => c['status'] == 'auditing' || c['status'] == 'rejected').length;
    final allSelected = state.selectedClaimIds.isNotEmpty && state.selectedClaimIds.length == auditableCount;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.fileSpreadsheet, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Insurance Claims Auditor Desk',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Hero Area
            Text(
              'Insurance Reconciliations',
              style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
            ),
            const SizedBox(height: 6),
            Text(
              'Weekly audit controls: private and government-backed claims.',
              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
            ),
            const SizedBox(height: 24),

            // Performance metrics grid
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    context,
                    'Pending Outstanding Claims',
                    '\$${state.outstandingClaimsVal.toStringAsFixed(2)}',
                    LucideIcons.clock,
                    Colors.amber,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    context,
                    'Reimbursed This Month',
                    '\$${state.reimbursedThisMonthVal.toStringAsFixed(2)}',
                    LucideIcons.checkCircle2,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    context,
                    'Claims Rejection Rate',
                    '4.2%',
                    LucideIcons.alertOctagon,
                    Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Bulk Batch Submission Drawer Tool
            if (state.selectedClaimIds.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: theme.colors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: theme.colors.primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.checkSquare, color: Colors.blue),
                        const SizedBox(width: 12),
                        Text(
                          '${state.selectedClaimIds.length} Claims Selected for Bulk Batch Submission',
                          style: theme.typography.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colors.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () => controller.toggleSelectAll(false),
                          child: const Text('Clear Selection'),
                        ),
                        const SizedBox(width: 12),
                        state.isSubmittingBatch
                            ? const CircularProgressIndicator()
                            : ElevatedButton.icon(
                                icon: const Icon(LucideIcons.send),
                                label: const Text('Process Bulk Claims Batch'),
                                onPressed: controller.submitSelectedBatch,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colors.primary,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // Claims Table Ledger View
            Container(
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(theme.radiusMd),
                border: Border.all(color: theme.colors.border),
              ),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      border: Border(bottom: BorderSide(color: theme.colors.border)),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: allSelected,
                          onChanged: (val) => controller.toggleSelectAll(val ?? false),
                          activeColor: theme.colors.primary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'PATIENT & CLAIM CODE',
                            style: theme.typography.labelBold.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'INSURANCE CARRIER',
                            style: theme.typography.labelBold.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'AMOUNT',
                            style: theme.typography.labelBold.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'STATUS',
                            style: theme.typography.labelBold.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'ACTIONS',
                            style: theme.typography.labelBold.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Table Body Entries
                  ...state.claims.map((claim) {
                    final isSelected = state.selectedClaimIds.contains(claim['id']);
                    final canSelect = claim['status'] == 'auditing' || claim['status'] == 'rejected';
                    final status = claim['status'] as String;

                    Color statusColor = Colors.grey;
                    if (status == 'reimbursed') statusColor = Colors.green;
                    if (status == 'auditing') statusColor = Colors.amber;
                    if (status == 'rejected') statusColor = Colors.red;

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: theme.colors.border)),
                        color: isSelected
                            ? theme.colors.primary.withValues(alpha: 0.02)
                            : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: canSelect ? (val) => controller.toggleSelectClaim((claim['id'] as String)) : null,
                            activeColor: theme.colors.primary,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (claim['client'] as String),
                                  style: theme.typography.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colors.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  (claim['claimCode'] as String),
                                  style: theme.typography.labelMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              (claim['insurer'] as String),
                              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '\$${(claim['amount'] as double).toStringAsFixed(2)}',
                              style: theme.typography.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colors.onSurface,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(theme.radiusSm),
                              ),
                              child: Text(
                                (claim['statusText'] as String),
                                style: theme.typography.labelBold.copyWith(color: statusColor),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                if (canSelect)
                                  IconButton(
                                    icon: const Icon(LucideIcons.checkCircle, color: Colors.green),
                                    onPressed: () => controller.manuallyReconcile((claim['id'] as String)),
                                    tooltip: 'Manually Approve',
                                  )
                                else
                                  const Icon(LucideIcons.shieldCheck, color: Colors.blue),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.labelBold.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: theme.typography.h2.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colors.onSurface,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
        ],
      ),
    );
  }
}
