import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/database/database_provider.dart';
import '../models/proposal_intake.dart';
import '../repositories/proposal_repository.dart';

part 'proposal_provider.g.dart';

@riverpod
ProposalRepository proposalRepository(Ref ref) {
  final db = ref.watch(governanceDatabaseProvider);
  return ProposalRepository(db);
}

@riverpod
class ProposalList extends _$ProposalList {
  @override
  Future<List<ProposalIntake>> build() async {
    final repo = ref.watch(proposalRepositoryProvider);
    final proposals = await repo.getAll();

    if (proposals.isEmpty) {
      // Seed initial mock data if empty
      final initialData = _getMockData();
      for (final p in initialData) {
        await repo.save(p);
      }
      return initialData;
    }

    return proposals;
  }

  Future<void> addProposal(ProposalIntake proposal) async {
    final repo = ref.read(proposalRepositoryProvider);
    await repo.save(proposal);
    ref.invalidateSelf();
  }

  Future<void> updateStatus(String id, String status) async {
    final repo = ref.read(proposalRepositoryProvider);
    final proposals = await future;
    final proposal = proposals.firstWhere((p) => p.id == id);
    await repo.save(proposal.copyWith(status: status));
    ref.invalidateSelf();
  }

  Future<void> deleteProposal(String id) async {
    final repo = ref.read(proposalRepositoryProvider);
    await repo.delete(id);
    ref.invalidateSelf();
  }

  List<ProposalIntake> _getMockData() {
    return [
      ProposalIntake(
        id: 'prop_001',
        title: 'PSW Patient Check-in Screen',
        description: 'A mobile-optimized screen for PSWs to record patient vitals and arrival times.',
        requestedBy: 'Clinical Ops Director',
        department: 'Nursing',
        office: 'North Region',
        role: 'PSW',
        priority: 'p1',
        businessGoal: 'Improve data accuracy and reduce paper-based logging latency.',
        problemStatement: 'Current logging is delayed by 24 hours due to paper processing.',
        expectedOutcome: 'Real-time visibility into patient wellness visits.',
        screenId: 'screen_psw_checkin',
        routePath: '/clinical/psw/checkin',
        allowedRoles: ['psw', 'clinical_director'],
        requiredApis: ['patient_api', 'vitals_api', 'visit_log_api'],
        requiredComponents: ['VitalsChart', 'SignaturePad', 'LocationTracker'],
        requiredForms: ['VitalsEntryForm', 'SafetyChecklist'],
        designSource: 'stitch',
        designUrl: 'https://stitch.google.com/p/primecare/s/psw_checkin',
        mockDataNotes: 'Need mock vitals for heart rate and SpO2.',
        needsPhiData: true,
        needsConsent: true,
        needsSignature: true,
        needsAuditLog: true,
        acceptanceCriteria: [
          'Screen loads patient data in < 2s',
          'Offline mode support for vitals logging',
          'Biometric signature capture'
        ],
        testScenarios: [
          'Verify data sync when network restored',
          'Validate PHI encryption at rest'
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        status: 'in_review',
      ),
      ProposalIntake(
        id: 'prop_002',
        title: 'Billing Admin Revenue Dashboard',
        description: 'Consolidated view of regional billing cycles and outstanding invoices.',
        requestedBy: 'CFO',
        department: 'Finance',
        office: 'Corporate',
        role: 'Billing Admin',
        priority: 'p0',
        businessGoal: 'Increase cash flow transparency across all regions.',
        problemStatement: 'Manual reports take 3 days to consolidate.',
        expectedOutcome: 'Daily revenue reports automated by region.',
        screenId: 'screen_billing_dashboard',
        routePath: '/corporate/billing/dashboard',
        allowedRoles: ['billing_admin', 'cfo'],
        requiredApis: ['billing_api', 'invoice_api'],
        requiredComponents: ['RevenueChart', 'InvoiceTable', 'RegionPicker'],
        requiredForms: [],
        designSource: 'figma',
        designUrl: 'https://figma.com/file/primecare/billing_v2',
        mockDataNotes: 'Randomized regional data for testing.',
        needsPhiData: false,
        needsConsent: false,
        needsSignature: false,
        needsAuditLog: true,
        acceptanceCriteria: [
          'Filter by regional office',
          'Export to PDF capability'
        ],
        testScenarios: [
          'Verify totals match billing API summary'
        ],
        createdAt: DateTime.now().subtract(const Duration(hours: 18)),
        status: 'proposal_received',
      ),
    ];
  }
}
