// Layer: 02_MODELS_FOUNDATION
import 'package:primecare_adapters/primecare_adapters.dart';

enum AuraEventType {
  occupancySpike,
  revenueDip,
  systemAlert,
  workforceEfficiency,
  stableheartbeat,
  marketingConversion,
  salesLeadPeak,
  territoryExpansion,
  hrPolicyAlert,
  volunteerMilestone,
  customerSentimentDip,
  territoryGrowth,
  regionalLogisticLag,
  franchiseSync,
  operationalRisk,
  complianceBreach,
  revenueTarget,
  criticalAlert,
  predictedStaffingGap,
  predictedBudgetOverrun,
  architecturalDrift,
}

class AuraEvent {
  final String id;
  final AuraEventType type;
  final String title;
  final String description;
  final InsightImpact impact;
  final DateTime timestamp;
  final bool isPredictive;
  final Map<String, dynamic>? metadata;

  AuraEvent({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.impact,
    required this.timestamp,
    this.isPredictive = false,
    this.metadata,
  });

  factory AuraEvent.stable() {
    return AuraEvent(
      id: 'stable_${DateTime.now().millisecondsSinceEpoch}',
      type: AuraEventType.stableheartbeat,
      title: 'System Stable',
      description: 'Institutional heartbeat is nominal.',
      impact: InsightImpact.info,
      timestamp: DateTime.now(),
    );
  }
}
