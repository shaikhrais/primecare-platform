// Governance - Category: view | Purpose: UI Screen component rendering the Psw Help Support workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class PswHelpSupportState {
  final String status;
  final double rating;
  final String feedbackText;
  final List<Map<String, String>> faqs;

  const PswHelpSupportState({
    required this.status,
    required this.rating,
    required this.feedbackText,
    required this.faqs,
  });

  PswHelpSupportState copyWith({
    String? status,
    double? rating,
    String? feedbackText,
    List<Map<String, String>>? faqs,
  }) {
    return PswHelpSupportState(
      status: status ?? this.status,
      rating: rating ?? this.rating,
      feedbackText: feedbackText ?? this.feedbackText,
      faqs: faqs ?? this.faqs,
    );
  }
}

// --- Controller ---
class PswHelpSupportController extends StateNotifier<PswHelpSupportState> {
  final Ref _ref;
  PswHelpSupportController(this._ref)
      : super(const PswHelpSupportState(
          status: 'idle',
          rating: 4.0,
          feedbackText: '',
          faqs: [
            {'q': 'How do I log an urgent care update?', 'a': 'Navigate to Care Updates screen, fill in details, and tick the "Urgent" check-box before submitting.'},
            {'q': 'What if my client refuses medication?', 'a': 'Log it in the daily notes, select "Refused" as the status, and contact your RN supervisor immediately.'},
            {'q': 'How do I request shift changes?', 'a': 'Open the Scheduler Dashboard, go to Booking Requests, and submit a new request.'},
          ],
        ));

  void updateRating(double val) {
    state = state.copyWith(rating: val);
  }

  void updateFeedback(String val) {
    state = state.copyWith(feedbackText: val);
  }

  void submitFeedback() {
    state = state.copyWith(status: 'submitted');
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/help/support',
        eventType: 'submitFeedback',
        metadata: {'rating': state.rating, 'text': state.feedbackText},
      );
    } catch (_) {}
  }

  void fetchFAQs() {
    print('Governance action: fetchFAQs executed.');
  }

  void contactSupport() {
    print('Governance action: contactSupport executed.');
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/help/support',
        eventType: 'contactSupport',
        metadata: {'action': 'call'},
      );
    } catch (_) {}
  }
}

final pswHelpSupportControllerProvider = StateNotifierProvider<PswHelpSupportController, PswHelpSupportState>((ref) {
  return PswHelpSupportController(ref);
});

// --- View ---
class PswHelpSupportScreen extends GovernedConsumerWidget {
  const PswHelpSupportScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(pswHelpSupportControllerProvider);
    final controller = ref.read(pswHelpSupportControllerProvider.notifier);

    return Semantics(
      label: 'data-cy:pswhelp-btn-submit-feedback',
      container: true,
      child: Scaffold(
        key: const Key('pswhelp-btn-submit-feedback'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(
            label: 'data-cy:pswhelp-btn-access-faqs',
            container: true,
            child: Container(
              child: Text(
                key: const Key('pswhelp-btn-access-faqs'),
                'Help & Support',
                style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
              ),
            ),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswhelpsupport-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('pswhelpsupport-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Live Support Panel
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: theme.colors.primaryContainer.withValues(alpha: 0.1),
                        child: Icon(LucideIcons.user, color: theme.colors.primary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Support Desk Hotline',
                              style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text('Available 24/7 for urgent clinical support', style: theme.typography.bodySmall),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        key: const Key('pswhelp-btn-contact-support'),
                        icon: const Icon(LucideIcons.phoneCall, size: 14),
                        label: const Text('Call'),
                        onPressed: () => controller.contactSupport(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // FAQ Section
                Text('Frequently Asked Questions', style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ...state.faqs.map((f) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusSm),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(f['q'] ?? '', style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(f['a'] ?? '', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                    ],
                  ),
                )),
                const SizedBox(height: 24),

                // Feedback Form
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: state.status == 'submitted' 
                    ? Center(
                        child: Text(
                          'Thank you for your feedback!',
                          style: theme.typography.bodyMedium.copyWith(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Submit Platform Feedback', style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Text('Rate your experience: ${state.rating.toInt()}/5', style: theme.typography.bodySmall),
                          Slider(
                            value: state.rating,
                            min: 1.0,
                            max: 5.0,
                            divisions: 4,
                            activeColor: theme.colors.primary,
                            onChanged: (val) => controller.updateRating(val),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your comments here...',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(theme.radiusSm)),
                            ),
                            maxLines: 3,
                            onChanged: (val) => controller.updateFeedback(val),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () => controller.submitFeedback(),
                              child: const Text('Submit Feedback'),
                            ),
                          ),
                        ],
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
