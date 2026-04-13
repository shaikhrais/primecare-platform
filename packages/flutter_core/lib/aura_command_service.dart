import 'src/models/aura_intent.dart';

class AuraCommandService {
  /// Processes raw natural language input into a structured [AuraIntent].
  /// Currently uses a high-performance keyword mapping engine, extensible to LLM synthesis.
  AuraIntent processQuery(String query) {
    final lowerQuery = query.toLowerCase();

    // 1. Navigation Scents
    if (lowerQuery.contains('revenue') || lowerQuery.contains('billing')) {
      return AuraIntent(
        rawQuery: query,
        title: 'Analyze Revenue Trajectory',
        description:
            'Navigating to the deep-drill revenue logs and predictive performance reports.',
        actions: [
          const AuraAction(
            type: AuraActionType.navigate,
            target: 'revenue_report',
          ),
        ],
      );
    }

    if (lowerQuery.contains('staff') || lowerQuery.contains('resource')) {
      return AuraIntent(
        rawQuery: query,
        title: 'Review Staffing Allocation',
        description:
            'Analyzing current nurse-to-patient ratios and department rosters.',
        actions: [
          const AuraAction(
            type: AuraActionType.navigate,
            target: 'staff_report',
          ),
        ],
      );
    }

    if (lowerQuery.contains('occupancy') ||
        lowerQuery.contains('ward') ||
        lowerQuery.contains('bed')) {
      return AuraIntent(
        rawQuery: query,
        title: 'Occupancy Volume Synthesis',
        description:
            'Filtering dashboard charts to focus on institutional capacity and ward distribution.',
        actions: [
          const AuraAction(
            type: AuraActionType.filter,
            target: 'occupancy_charts',
          ),
        ],
      );
    }

    // 2. Generic Performance Scents
    if (lowerQuery.contains('trend') ||
        lowerQuery.contains('performance') ||
        lowerQuery.contains('how is')) {
      return AuraIntent(
        rawQuery: query,
        title: 'Institutional Pulse Check',
        description: 'Summarizing top-line KPIs and active operational alerts.',
        actions: [
          const AuraAction(type: AuraActionType.summarize, target: 'dashboard'),
        ],
      );
    }

    // 3. Unknown Trigger
    return AuraIntent(
      rawQuery: query,
      title: 'Synthesizing Query...',
      description:
          'Aura is searching for the relevant institutional context for "$query".',
      actions: [],
      confidence: 0.0,
    );
  }

  /// Provides suggested queries for the user.
  List<String> getSuggestions() {
    return [
      'Show me revenue trends',
      'How is staffing today?',
      'Check ward occupancy',
      'Monthly performance summary',
    ];
  }
}
