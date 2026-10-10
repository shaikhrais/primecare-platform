// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Processes raw natural language input into a structured [AuraIntent]. Currently uses a high-p...
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_models/primecare_models.dart';
import '../application/base_result_service.dart';

class AuraCommandService extends BaseResultService {
  /// Processes raw natural language input into a structured [AuraIntent].
  /// Currently uses a high-performance keyword mapping engine, extensible to LLM synthesis.
  Result<AuraIntent> processQuery(String query) {
    return guardSync<AuraIntent>(
      () {
        final lowerQuery = query.toLowerCase();

        // Scheduling / Reassignment intents
        if (lowerQuery.contains('reassign') ||
            lowerQuery.contains('schedule') ||
            lowerQuery.contains('move')) {
          final targetResource = lowerQuery
              .replaceAll(RegExp(r'(reassign|schedule|move|to|from)'), '')
              .trim();
          return AuraIntent(
            id: 'aura_reassign_${DateTime.now().millisecondsSinceEpoch}',
            rawQuery: query,
            title: 'Schedule Reallocation',
            description: 'Initiating smart reassignment for $targetResource.',
            actions: [
              AuraAction(type: AuraActionType.reassign, target: targetResource),
            ],
          );
        }

        // Snooze intents
        if (lowerQuery.contains('snooze') ||
            lowerQuery.contains('quiet') ||
            lowerQuery.contains('mute')) {
          return AuraIntent(
            id: 'aura_snooze_${DateTime.now().millisecondsSinceEpoch}',
            rawQuery: query,
            title: 'Snooze Aura Alerts',
            description: 'Silencing HUD anomaly alerts temporarily.',
            actions: [
              const AuraAction(type: AuraActionType.snooze, target: ''),
            ],
          );
        }

        // Navigation Scents to ScreenRegistry
        if (lowerQuery.contains('revenue') ||
            lowerQuery.contains('billing') ||
            lowerQuery.contains('finance')) {
          return AuraIntent(
            id: 'aura_nav_finance_${DateTime.now().millisecondsSinceEpoch}',
            rawQuery: query,
            title: 'Analyze Financial Trajectory',
            description: 'Navigating to the CFO Financial Overview dashboard.',
            actions: [
              const AuraAction(
                type: AuraActionType.navigate,
                target:
                    '/offices/corporate/roles/cfo/financial-overview', // cfoFinancialOverview
              ),
            ],
          );
        }

        if (lowerQuery.contains('staff') ||
            lowerQuery.contains('resource') ||
            lowerQuery.contains('nurses')) {
          return AuraIntent(
            id: 'aura_nav_staffing_${DateTime.now().millisecondsSinceEpoch}',
            rawQuery: query,
            title: 'Review Staffing Allocation',
            description: 'Navigating to COO Staffing Efficiency dashboard.',
            actions: [
              const AuraAction(
                type: AuraActionType.navigate,
                target:
                    '/offices/corporate/roles/coo/staffing-efficiency', // cooStaffingEfficiency
              ),
            ],
          );
        }

        if (lowerQuery.contains('occupancy') ||
            lowerQuery.contains('ward') ||
            lowerQuery.contains('bed')) {
          return AuraIntent(
            id: 'aura_nav_scheduler_${DateTime.now().millisecondsSinceEpoch}',
            rawQuery: query,
            title: 'Occupancy Volume Synthesis',
            description: 'Navigating to the Institutional Scheduler.',
            actions: [
              const AuraAction(
                type: AuraActionType.navigate,
                target: '/institutional/scheduler', // institutionalScheduler
              ),
            ],
          );
        }

        if (lowerQuery.contains('icu') || lowerQuery.contains('report')) {
          return AuraIntent(
            id: 'aura_nav_log_${DateTime.now().millisecondsSinceEpoch}',
            rawQuery: query,
            title: 'Drill Down Log',
            description: 'Navigating to the default institutional log reports.',
            actions: [
              const AuraAction(
                type: AuraActionType.navigate,
                target:
                    'revenue_log', // Fallback to PrimeCareReportScreen if not a route
              ),
            ],
          );
        }

        // Generic Performance Scents
        if (lowerQuery.contains('trend') ||
            lowerQuery.contains('performance') ||
            lowerQuery.contains('how is')) {
          return AuraIntent(
            id: 'aura_nav_pulse_${DateTime.now().millisecondsSinceEpoch}',
            rawQuery: query,
            title: 'Institutional Pulse Check',
            description:
                'Navigating to the Global Platform Overview dashboard.',
            actions: [
              const AuraAction(
                type: AuraActionType.navigate,
                target:
                    '/offices/corporate/roles/ceo/dashboard', // ceoDashboard
              ),
            ],
          );
        }

        // Unknown Trigger
        return AuraIntent(
          id: 'aura_unknown_${DateTime.now().millisecondsSinceEpoch}',
          rawQuery: query,
          title: 'Synthesizing Query...',
          description:
              'Aura is searching for the relevant institutional context for "$query".',
          actions: [],
          confidence: 0.0,
        );
      },
      onError: (e, st) {
        // Checkpoint: Gracefully handle any dynamic parsing failures, ensuring the UI
        // receives a safe standard state rather than a crash from null values.
        return AuraIntent(
          id: 'aura_error_${DateTime.now().millisecondsSinceEpoch}',
          rawQuery: query,
          title: 'Query Interrupted',
          description:
              'Aura encountered a dynamic boundary issue and safely aborted the query.',
          actions: const [AuraAction(type: AuraActionType.unknown, target: '')],
          confidence: 0.0,
        );
      },
    );
  }

  /// Provides suggested queries for the user, optionally filtered by context.
  List<String> getSuggestions({String? context}) {
    final base = ['Snooze alerts', 'Show me performance'];

    if (context == null) {
      return [...base, 'Show me finance', 'Check ward occupancy'];
    }

    final lowerContext = context.toLowerCase();

    if (lowerContext.contains('finance') || lowerContext.contains('cfo')) {
      return [
        'Analyze revenue leakage',
        'Show budget variance',
        'Review ledger audit',
        ...base,
      ];
    }

    if (lowerContext.contains('staff') || lowerContext.contains('coo')) {
      return [
        'Review nurse allocation',
        'Show shift gaps',
        'Optimize staff efficiency',
        ...base,
      ];
    }

    if (lowerContext.contains('scheduler') ||
        lowerContext.contains('institutional')) {
      return [
        'Check bed occupancy',
        'Show discharge trends',
        'Analyze patient flow',
        ...base,
      ];
    }

    return [...base, 'Show me $context details'];
  }
}
