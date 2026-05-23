// Governance - Category: view | Purpose: --- MVC State Model ---
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class RnAssessmentsState {
  final double mobilityScore;
  final double cognitiveScore;
  final double nutritionalScore;
  final bool isSubmitting;
  final List<Map<String, dynamic>> assessmentHistory;

  const RnAssessmentsState({
    this.mobilityScore = 5.0,
    this.cognitiveScore = 5.0,
    this.nutritionalScore = 5.0,
    this.isSubmitting = false,
    this.assessmentHistory = const [],
  });

  RnAssessmentsState copyWith({
    double? mobilityScore,
    double? cognitiveScore,
    double? nutritionalScore,
    bool? isSubmitting,
    List<Map<String, dynamic>>? assessmentHistory,
  }) {
    return RnAssessmentsState(
      mobilityScore: mobilityScore ?? this.mobilityScore,
      cognitiveScore: cognitiveScore ?? this.cognitiveScore,
      nutritionalScore: nutritionalScore ?? this.nutritionalScore,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      assessmentHistory: assessmentHistory ?? this.assessmentHistory,
    );
  }
}

// --- Controller (Notifier) ---
class RnAssessmentsController extends StateNotifier<RnAssessmentsState> {
  final Ref _ref;

  RnAssessmentsController(this._ref)
      : super(
          RnAssessmentsState(
            assessmentHistory: [
              {
                'id': 'ASM-902',
                'client': 'Margaret Thompson',
                'date': '2026-05-10',
                'overallScore': 7.2,
                'status': 'completed',
              },
              {
                'id': 'ASM-901',
                'client': 'Arthur Pendelton',
                'date': '2026-05-02',
                'overallScore': 6.8,
                'status': 'completed',
              },
            ],
          ),
        );

  void updateMobility(double val) => state = state.copyWith(mobilityScore: val);
  void updateCognitive(double val) => state = state.copyWith(cognitiveScore: val);
  void updateNutritional(double val) => state = state.copyWith(nutritionalScore: val);

  Future<void> submitAssessment(String clientName) async {
    state = state.copyWith(isSubmitting: true);
    await Future<void>.delayed(const Duration(milliseconds: 800));

    final overall = (state.mobilityScore + state.cognitiveScore + state.nutritionalScore) / 3;
    final newAssessment = {
      'id': 'ASM-${900 + state.assessmentHistory.length + 1}',
      'client': clientName,
      'date': DateTime.now().toIso8601String().substring(0, 10),
      'overallScore': double.parse(overall.toStringAsFixed(1)),
      'status': 'completed',
    };

    state = state.copyWith(
      isSubmitting: false,
      assessmentHistory: [newAssessment, ...state.assessmentHistory],
      mobilityScore: 5.0,
      cognitiveScore: 5.0,
      nutritionalScore: 5.0,
    );

    // Logging telemetry event via execution gate
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/rn/assessments',
            eventType: 'rn_assessment_submitted',
            metadata: {'client': clientName, 'score': overall},
          );
    } catch (_) {}
  }
}

// --- Provider ---
final rnAssessmentsControllerProvider =
    StateNotifierProvider<RnAssessmentsController, RnAssessmentsState>((ref) {
  return RnAssessmentsController(ref);
});

// --- View ---
class RnAssessmentsScreen extends GovernedConsumerWidget {
  const RnAssessmentsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rnAssessmentsControllerProvider);
    final controller = ref.read(rnAssessmentsControllerProvider.notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'Clinical Assessments',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Clinical Scoring Form
            _buildAssessmentForm(context, state, controller),
            const SizedBox(height: 28),
            // Assessment History
            Text(
              'Assessment History',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
            const SizedBox(height: 12),
            ...state.assessmentHistory.map((asm) => _buildHistoryCard(context, asm)),
          ],
        ),
      ),
    );
  }

  Widget _buildAssessmentForm(
    BuildContext context,
    RnAssessmentsState state,
    RnAssessmentsController controller,
  ) {
    final theme = context.theme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Client Assessment',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          const SizedBox(height: 6),
          Text(
            'Score each clinical category carefully according to current patient symptoms.',
            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          // Category 1: Mobility
          _buildSliderCategory(
            context,
            'Physical Mobility & Gait',
            state.mobilityScore,
            controller.updateMobility,
            '1 = Immobile / Bedbound',
            '10 = Fully Autonomous',
          ),
          const SizedBox(height: 20),
          // Category 2: Cognitive
          _buildSliderCategory(
            context,
            'Cognitive Standing & Memory',
            state.cognitiveScore,
            controller.updateCognitive,
            '1 = Severe Impairment',
            '10 = Fully Alert & Oriented',
          ),
          const SizedBox(height: 20),
          // Category 3: Nutritional
          _buildSliderCategory(
            context,
            'Nutritional Integrity & Appetite',
            state.nutritionalScore,
            controller.updateNutritional,
            '1 = High Risk / Tube Fed',
            '10 = Solid Diet Intake',
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: state.isSubmitting
                  ? null
                  : () => controller.submitAssessment('Margaret Thompson'),
              child: state.isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Text(
                      'Record Clinical Assessment',
                      style: theme.typography.button.copyWith(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderCategory(
    BuildContext context,
    String label,
    double value,
    ValueChanged<double> onChanged,
    String leftLabel,
    String rightLabel,
  ) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.typography.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colors.onSurface,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: theme.colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                value.toStringAsFixed(1),
                style: theme.typography.labelSmall.copyWith(
                  color: theme.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: value,
          min: 1.0,
          max: 10.0,
          divisions: 18,
          activeColor: theme.colors.primary,
          inactiveColor: theme.colors.background,
          onChanged: onChanged,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(leftLabel, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
            Text(rightLabel, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
          ],
        ),
      ],
    );
  }

  Widget _buildHistoryCard(BuildContext context, Map<String, dynamic> asm) {
    final theme = context.theme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusSm),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (asm['client'] as String?) ?? '',
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colors.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Recorded on ${asm['date']}',
                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Score: ${asm['overallScore']}',
              style: theme.typography.labelSmall.copyWith(
                color: theme.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
