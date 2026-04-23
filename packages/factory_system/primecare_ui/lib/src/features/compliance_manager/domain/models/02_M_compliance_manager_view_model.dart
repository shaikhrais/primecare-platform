// Layer: 02_MODELS
import 'package:equatable/equatable.dart';

class ComplianceManagerViewModel extends Equatable {
  final double complianceRate;
  final int pendingAudits;
  final List<String> regulatoryAlerts;

  const ComplianceManagerViewModel({
    required this.complianceRate,
    required this.pendingAudits,
    required this.regulatoryAlerts,
  });

  @override
  List<Object?> get props => [complianceRate, pendingAudits, regulatoryAlerts];
}
