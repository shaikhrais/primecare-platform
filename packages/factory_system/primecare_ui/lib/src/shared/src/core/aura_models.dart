// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/core/dashboard_models.dart';

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
  hydrationMetrics,
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
      title: 'aura.events.stable_title',
      description: 'aura.events.stable_desc',
      impact: InsightImpact.info,
      timestamp: DateTime.now(),
    );
  }
}

/// A provider that holds the latest Aura Pulse event.
/// This is typically populated by the AuraPulseService in flutter_core.
class AuraPulseEventNotifier extends Notifier<AuraEvent?> {
  @override
  AuraEvent? build() => null;
  
  set state(AuraEvent? value) => super.state = value;
}

final auraPulseEventProvider = NotifierProvider<AuraPulseEventNotifier, AuraEvent?>(() {
  return AuraPulseEventNotifier();
});
