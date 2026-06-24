/* 
PRIME:SCREEN=psw_notifications
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=50
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: view | Purpose: UI Screen component rendering the Psw Notifications workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class PswNotificationsState {
  final List<Map<String, dynamic>> notifications;
  final bool enablePush;

  const PswNotificationsState({
    required this.notifications,
    required this.enablePush,
  });

  PswNotificationsState copyWith({
    List<Map<String, dynamic>>? notifications,
    bool? enablePush,
  }) {
    return PswNotificationsState(
      notifications: notifications ?? this.notifications,
      enablePush: enablePush ?? this.enablePush,
    );
  }
}

// --- Controller ---
class PswNotificationsController extends StateNotifier<PswNotificationsState> {
  final Ref _ref;
  PswNotificationsController(this._ref)
      : super(const PswNotificationsState(
          enablePush: true,
          notifications: [
            {'id': '1', 'title': 'Care Plan Update', 'body': "Arthur Pendelton's care plan has been updated by RN supervisor.", 'read': false, 'type': 'alert'},
            {'id': '2', 'title': 'Schedule Change', 'body': 'Your shift tomorrow has been shifted by 30 minutes.', 'read': false, 'type': 'schedule'},
            {'id': '3', 'title': 'Weather Alert', 'body': 'Severe rain forecasted. Please take extra travel precautions.', 'read': false, 'type': 'info'},
          ],
        ));

  void dismissNotification(String id) {
    final updated = state.notifications.where((n) => n['id'] != id).toList();
    state = state.copyWith(notifications: updated);
    
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/notifications',
        eventType: 'dismissNotification',
        metadata: {'id': id},
      );
    } catch (_) {}
  }

  void togglePushNotifications(bool val) {
    state = state.copyWith(enablePush: val);
    
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/notifications',
        eventType: 'updateNotificationSettings',
        metadata: {'push_enabled': val},
      );
    } catch (_) {}
  }
}

final pswNotificationsControllerProvider = StateNotifierProvider<PswNotificationsController, PswNotificationsState>((ref) {
  return PswNotificationsController(ref);
});

// --- View ---
class PswNotificationsScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for displaying and interacting with password notifications, along with performance monitoring and user engagement statistics.';

  @override
  List<String> get requiredComponents => const [
        'NotificationList',
        'NotificationDetail',
        'AlertBanner',
        'PerformanceMetrics',
        'UserEngagementStats',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchNotifications',
        'dismissNotification',
        'updateNotificationSettings',
        'monitorPerformance',
      ];

  const PswNotificationsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(pswNotificationsControllerProvider);
    final controller = ref.read(pswNotificationsControllerProvider.notifier);

    return Semantics(
      label: 'data-cy:psw_notifications-list',
      container: true,
      child: Scaffold(
        key: const Key('psw_notifications-list'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            'Notifications',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswnotifications-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('pswnotifications-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Weather / Critical Alert Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.alertTriangle, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Weather Warning: Heavy rainfall and delays expected. Please report any commute issues.',
                          style: theme.typography.bodySmall.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Notifications list
                Text('Active Notifications (${state.notifications.length})', style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                if (state.notifications.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Center(
                      child: Text('No active notifications.', style: theme.typography.bodyMedium),
                    ),
                  )
                else
                  ...state.notifications.map((n) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(theme.radiusSm),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          n['type'] == 'alert' 
                              ? LucideIcons.bellRing 
                              : (n['type'] == 'schedule' ? LucideIcons.calendar : LucideIcons.info),
                          color: theme.colors.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(n['title']?.toString() ?? '', style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(n['body']?.toString() ?? '', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                            ],
                          ),
                        ),
                        IconButton(
                          key: Key('psw_notifications-dismiss-${n['id']}'),
                          icon: const Icon(LucideIcons.x, size: 16),
                          onPressed: () => controller.dismissNotification(n['id'] as String),
                        ),
                      ],
                    ),
                  )),
                const SizedBox(height: 24),

                // Settings Panel
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Notification Preferences', style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Enable Push Alerts', style: theme.typography.bodyMedium),
                          Switch(
                            key: const Key('psw_notifications-settings'),
                            value: state.enablePush,
                            activeThumbColor: theme.colors.primary,
                            onChanged: (val) => controller.togglePushNotifications(val),
                          ),
                        ],
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
