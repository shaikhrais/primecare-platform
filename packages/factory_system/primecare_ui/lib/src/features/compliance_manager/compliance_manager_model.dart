import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ComplianceManagerViewModel {
  final List<String> pendingAudits;
  final double complianceScore;

  const ComplianceManagerViewModel({
    required this.pendingAudits,
    required this.complianceScore,
  });

  factory ComplianceManagerViewModel.initial() {
    return const ComplianceManagerViewModel(
      pendingAudits: ['Quarterly Safety Audit', 'Staff Certification Review'],
      complianceScore: 0.98,
    );
  }
}
