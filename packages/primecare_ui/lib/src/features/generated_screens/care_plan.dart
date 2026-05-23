// Governance - Category: service | Purpose: --- MVC State Model ---
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class CarePlanState {
  final double overallProgress;
  final List<Map<String, dynamic>> goals;
  final bool submissionPending;
  final bool showSuccess;

  const CarePlanState({
    required this.overallProgress,
    required this.goals,
    required this.submissionPending,
    required this.showSuccess,
  });

  CarePlanState copyWith({
    double? overallProgress,
    List<Map<String, dynamic>>? goals,
    bool? submissionPending,
    bool? showSuccess,
  }) {
    return CarePlanState(
      overallProgress: overallProgress ?? this.overallProgress,
      goals: goals ?? this.goals,
      submissionPending: submissionPending ?? this.submissionPending,
      showSuccess: showSuccess ?? this.showSuccess,
    );
  }
}

// --- Controller ---
class CarePlanController extends StateNotifier<CarePlanState> {
  final Ref _ref;

  CarePlanController(this._ref)
      : super(
          const CarePlanState(
            overallProgress: 82.5,
            goals: [
              {
                'id': 'goal-1',
                'title': 'Mobility Rehabilitation Phase II',
                'description': 'Perform 20 mins of supported walking, daily hamstring stretching, and range-of-motion leg exercises.',
                'progress': 0.90,
                'targetDate': 'Jun 15, 2026',
                'discipline': 'Physiotherapy',
              },
              {
                'id': 'goal-2',
                'title': 'Cognitive Impairment Engagement',
                'description': 'Engage in standard MMSE cognitive drills, card recall exercises, and active daily dialogue scripts.',
                'progress': 0.80,
                'targetDate': 'Jul 01, 2026',
                'discipline': 'RN Coordination',
              },
              {
                'id': 'goal-3',
                'title': 'Cardiovascular Vital Stability',
                'description': 'Stabilize arterial blood pressure within 120-135 systolic range. Log dual daily pressure logs.',
                'progress': 0.75,
                'targetDate': 'Jun 30, 2026',
                'discipline': 'RPN Operations',
              },
            ],
            submissionPending: false,
            showSuccess: false,
          ),
        );

  void toggleGoalDone(String goalId) {
    final updatedGoals = state.goals.map((g) {
      if (g['id'] == goalId) {
        final currentProg = g['progress'] as double;
        final nextProg = currentProg >= 1.0 ? 0.0 : 1.0;
        return Map<String, dynamic>.from(g)..['progress'] = nextProg;
      }
      return g;
    }).toList();

    // Recalculate overall average progress
    final double sum = updatedGoals.fold(0.0, (s, g) => s + (g['progress'] as double));
    final double newAvg = updatedGoals.isEmpty ? 0.0 : (sum / updatedGoals.length) * 100;

    state = state.copyWith(
      goals: updatedGoals,
      overallProgress: double.parse(newAvg.toStringAsFixed(1)),
    );

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/client_treatment_history',
            eventType: 'care_plan_goal_toggled',
            metadata: {'goalId': goalId, 'newProgress': newAvg},
          );
    } catch (_) {}
  }

  void submitWellnessFeedback(double mood, double mobility, double pain, String feedback) {
    state = state.copyWith(submissionPending: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/client_treatment_history',
            eventType: 'care_plan_feedback_submitted',
            metadata: {
              'rating_mood': mood,
              'rating_mobility': mobility,
              'rating_pain': pain,
              'feedback_length': feedback.length,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 600), () {
      state = state.copyWith(
        submissionPending: false,
        showSuccess: true,
      );
    });
  }

  void dismissSuccess() {
    state = state.copyWith(showSuccess: false);
  }
}

// --- Provider ---
final carePlanControllerProvider =
    StateNotifierProvider<CarePlanController, CarePlanState>((ref) {
  return CarePlanController(ref);
});

// --- View ---
class CarePlan extends GovernedConsumerWidget {
  const CarePlan({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(carePlanControllerProvider);
    final controller = ref.read(carePlanControllerProvider.notifier);
    final theme = context.theme;

    // Controllers for sliders
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.clipboardList, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Active Care Plans',
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
            if (state.showSuccess)
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.shieldCheck, color: Colors.green, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Weekly wellness feedback successfully recorded!',
                        style: theme.typography.bodyMedium.copyWith(color: Colors.green.shade800),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.x, size: 16, color: Colors.green),
                      onPressed: controller.dismissSuccess,
                    ),
                  ],
                ),
              ),

            // Top Milestones Summary Chart
            PrimeCareCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Overall Milestone Progress', style: theme.typography.labelMedium),
                          const SizedBox(height: 4),
                          Text(
                            '${state.overallProgress}% Completed',
                            style: theme.typography.h2.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(LucideIcons.trendingUp, color: theme.colors.primary, size: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(theme.radiusFull),
                    child: LinearProgressIndicator(
                      value: state.overallProgress / 100,
                      minHeight: 12,
                      backgroundColor: theme.colors.divider,
                      valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Margaret is demonstrating excellent recovery pacing in clinical rehabilitation exercises.',
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Active Care Goals
            Text('Target Goals & Checklists', style: theme.typography.h3),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.goals.length,
              itemBuilder: (context, index) {
                final goal = state.goals[index];
                final progress = goal['progress'] as double;
                final isCompleted = progress >= 1.0;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.divider),
                    boxShadow: theme.shadowsSurface1,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Active Checkbox
                      IconButton(
                        icon: Icon(
                          isCompleted ? LucideIcons.checkSquare : LucideIcons.square,
                          color: isCompleted ? theme.colors.primary : theme.colors.onSurfaceVariant,
                          size: 24,
                        ),
                        onPressed: () => controller.toggleGoalDone(goal['id'] as String),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: theme.colors.primary.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(theme.radiusSm),
                                  ),
                                  child: Text(
                                    goal['discipline'] as String,
                                    style: theme.typography.bodySmall.copyWith(color: theme.colors.primary, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  'Due ${goal['targetDate']}',
                                  style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              goal['title'] as String,
                              style: theme.typography.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: isCompleted ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              goal['description'] as String,
                              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                            const SizedBox(height: 12),
                            // Goal Progress Indicators
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(theme.radiusFull),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      minHeight: 6,
                                      backgroundColor: theme.colors.divider,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        isCompleted ? Colors.green : theme.colors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '${(progress * 100).toInt()}%',
                                  style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // Wellness Feedback Matrix Form
            Text('Wellness Feedback Board', style: theme.typography.h3),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => _showFeedbackSheet(context, controller),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.colors.primary.withValues(alpha: 0.05), theme.colors.primary.withValues(alpha: 0.15)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: theme.colors.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Submit Daily Wellness Ratings',
                            style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: theme.colors.primary),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Provide direct rating inputs on patient comfort, mobility pain, and mood levels to guide medical revisions.',
                            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(LucideIcons.messageSquarePlus, color: theme.colors.primary, size: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFeedbackSheet(
    BuildContext context,
    CarePlanController controller,
  ) {
    final theme = context.theme;
    double moodRating = 8.0;
    double mobilityRating = 7.0;
    double painRating = 3.0;
    final feedbackTextController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 32,
              ),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.colors.divider,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Care Satisfaction & Wellness Ratings', style: theme.typography.h3),
                  const SizedBox(height: 6),
                  Text(
                    'Direct quantitative logs mapped into clinical supervisor dashboards.',
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),

                  // Mood Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Client General Mood Level', style: theme.typography.labelBold),
                      Text('${moodRating.toInt()}/10', style: theme.typography.bodyMedium.copyWith(color: theme.colors.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Slider(
                    value: moodRating,
                    min: 1.0,
                    max: 10.0,
                    divisions: 9,
                    activeColor: theme.colors.primary,
                    onChanged: (val) => setState(() => moodRating = val),
                  ),
                  const SizedBox(height: 16),

                  // Mobility Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Client Mobility Autonomy', style: theme.typography.labelBold),
                      Text('${mobilityRating.toInt()}/10', style: theme.typography.bodyMedium.copyWith(color: theme.colors.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Slider(
                    value: mobilityRating,
                    min: 1.0,
                    max: 10.0,
                    divisions: 9,
                    activeColor: theme.colors.primary,
                    onChanged: (val) => setState(() => mobilityRating = val),
                  ),
                  const SizedBox(height: 16),

                  // Pain Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Reported Pain Discomfort', style: theme.typography.labelBold),
                      Text('${painRating.toInt()}/10', style: theme.typography.bodyMedium.copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Slider(
                    value: painRating,
                    min: 1.0,
                    max: 10.0,
                    divisions: 9,
                    activeColor: Colors.red,
                    inactiveColor: theme.colors.divider,
                    onChanged: (val) => setState(() => painRating = val),
                  ),
                  const SizedBox(height: 20),

                  // Notes Textarea
                  PrimeCareTextField(
                    label: 'Qualitative Care Notes & Feedback',
                    hintText: 'Share any observations about caregiver interactions or rehabilitation exercises...',
                    controller: feedbackTextController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(theme.radiusDefault),
                        ),
                      ),
                      onPressed: () {
                        controller.submitWellnessFeedback(
                          moodRating,
                          mobilityRating,
                          painRating,
                          feedbackTextController.text,
                        );
                        Navigator.pop(context);
                      },
                      child: Text('Submit Wellness Report', style: theme.typography.labelBold),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
