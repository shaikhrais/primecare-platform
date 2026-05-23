// Governance - Category: service | Purpose: Core implementation file for the Referrals platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class ReferralsState {
  final List<Map<String, dynamic>> referrals;
  final String activeTab;
  final bool isMutatingState;

  const ReferralsState({
    required this.referrals,
    required this.activeTab,
    required this.isMutatingState,
  });

  ReferralsState copyWith({
    List<Map<String, dynamic>>? referrals,
    String? activeTab,
    bool? isMutatingState,
  }) {
    return ReferralsState(
      referrals: referrals ?? this.referrals,
      activeTab: activeTab ?? this.activeTab,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class ReferralsController extends StateNotifier<ReferralsState> {
  final Ref _ref;

  ReferralsController(this._ref)
      : super(
          const ReferralsState(
            referrals: [
              {
                'id': 'ref-501',
                'name': 'Margaret Thatcher',
                'source': 'Mt. Sinai Cardiology',
                'reason': 'Post-stroke rehab management',
                'status': 'Pending Review',
                'date': '2025-05-20',
              },
              {
                'id': 'ref-502',
                'name': 'Gordon Ramsay',
                'source': 'St. Michael Hospital',
                'reason': 'Diabetes home monitoring',
                'status': 'Pending Review',
                'date': '2025-05-19',
              },
              {
                'id': 'ref-503',
                'name': 'Simon Cowell',
                'source': 'Dr. Aris (GP)',
                'reason': 'Cognitive assessment scheduling',
                'status': 'Accepted',
                'date': '2025-05-18',
              },
            ],
            activeTab: 'Pending',
            isMutatingState: false,
          ),
        );

  void updateTab(String tab) {
    state = state.copyWith(activeTab: tab);
  }

  void acceptReferral(String referralId) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/referrals',
            eventType: 'referral_accepted',
            metadata: {'referralId': referralId},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final updated = state.referrals.map((r) {
        if (r['id'] == referralId) {
          return {...r, 'status': 'Accepted'};
        }
        return r;
      }).toList();

      state = state.copyWith(
        referrals: updated,
        isMutatingState: false,
      );
    });
  }

  void rejectReferral(String referralId) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/referrals',
            eventType: 'referral_rejected',
            metadata: {'referralId': referralId},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final updated = state.referrals.map((r) {
        if (r['id'] == referralId) {
          return {...r, 'status': 'Rejected'};
        }
        return r;
      }).toList();

      state = state.copyWith(
        referrals: updated,
        isMutatingState: false,
      );
    });
  }
}

// --- Provider ---
final referralsControllerProvider =
    StateNotifierProvider<ReferralsController, ReferralsState>((ref) {
  return ReferralsController(ref);
});

// --- View ---
class Referrals extends GovernedConsumerWidget {
  const Referrals({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(referralsControllerProvider);
    final controller = ref.read(referralsControllerProvider.notifier);
    final theme = context.theme;

    final filteredList = state.referrals.where((r) {
      if (state.activeTab == 'Pending') {
        return r['status'] == 'Pending Review';
      }
      return r['status'] == state.activeTab;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.gitPullRequest, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Incoming Referrals Pipeline',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs Row
            Row(
              children: ['Pending', 'Accepted', 'Rejected'].map((tab) {
                final isSelected = state.activeTab == tab;
                return GestureDetector(
                  onTap: () => controller.updateTab(tab),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? theme.colors.primary : theme.colors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Text(
                      tab,
                      style: theme.typography.bodyMedium.copyWith(
                        color: isSelected ? theme.colors.onPrimary : theme.colors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Referral Items list
            Expanded(
              child: filteredList.isEmpty
                  ? Center(
                      child: Text(
                        'No referrals found for this section.',
                        style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurfaceVariant),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        final isPending = item['status'] == 'Pending Review';
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          color: theme.colors.surface,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      item['name'] as String,
                                      style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: theme.colors.primary.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        item['status'] as String,
                                        style: theme.typography.bodySmall.copyWith(
                                          color: theme.colors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Source: ${item['source']}',
                                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                                Text(
                                  'Reason: ${item['reason']}',
                                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                                const SizedBox(height: 12),
                                if (isPending)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () => controller.rejectReferral((item['id'] as String)),
                                        child: const Text('Decline'),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: () => controller.acceptReferral((item['id'] as String)),
                                        child: const Text('Accept Referral'),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
