// Governance - Category: view | Purpose: UI Screen component rendering the Psw Check In workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class PswCheckInScreenState {
  final String status; // 'Checked Out', 'Checking In', 'Checked In'
  final String? currentShift;
  final String? currentLocation;
  final List<Map<String, String>> history;

  const PswCheckInScreenState({
    required this.status,
    this.currentShift,
    this.currentLocation,
    required this.history,
  });

  PswCheckInScreenState copyWith({
    String? status,
    String? currentShift,
    String? currentLocation,
    List<Map<String, String>>? history,
  }) {
    return PswCheckInScreenState(
      status: status ?? this.status,
      currentShift: currentShift ?? this.currentShift,
      currentLocation: currentLocation ?? this.currentLocation,
      history: history ?? this.history,
    );
  }
}

// --- Controller ---
class PswCheckInScreenController extends StateNotifier<PswCheckInScreenState> {
  final Ref _ref;
  PswCheckInScreenController(this._ref)
      : super(const PswCheckInScreenState(
          status: 'Checked Out',
          history: [
            {'date': '2026-06-05', 'shift': 'Morning Shift', 'location': 'North Care Facility', 'action': 'Check-Out at 16:30'},
            {'date': '2026-06-05', 'shift': 'Morning Shift', 'location': 'North Care Facility', 'action': 'Check-In at 08:00'},
            {'date': '2026-06-04', 'shift': 'Afternoon Shift', 'location': 'Downtown Care Hub', 'action': 'Check-Out at 22:00'},
          ],
        ));

  void handleCheckIn(String shift, String location) {
    if (state.status == 'Checked In') return;
    
    state = state.copyWith(status: 'Checking In');
    Future.delayed(const Duration(milliseconds: 600), () {
      final newHistory = [
        {'date': '2026-06-06', 'shift': shift, 'location': location, 'action': 'Check-In at 08:00 (Today)'},
        ...state.history,
      ];
      state = state.copyWith(
        status: 'Checked In',
        currentShift: shift,
        currentLocation: location,
        history: newHistory,
      );
      
      try {
        _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
          route: '/psw/check/in',
          eventType: 'handleCheckIn',
          metadata: {'shift': shift, 'location': location, 'status': 'success'},
        );
      } catch (_) {}
    });
  }

  void handleCheckOut() {
    if (state.status != 'Checked In') return;
    
    final shift = state.currentShift ?? 'Morning Shift';
    final location = state.currentLocation ?? 'North Care Facility';
    
    final newHistory = [
      {'date': '2026-06-06', 'shift': shift, 'location': location, 'action': 'Check-Out at 16:30 (Today)'},
      ...state.history,
    ];
    state = state.copyWith(
      status: 'Checked Out',
      currentShift: null,
      currentLocation: null,
      history: newHistory,
    );

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/check/in',
        eventType: 'handleCheckOut',
        metadata: {'status': 'success'},
      );
    } catch (_) {}
  }

  void fetchUserStatus() {
    print('Governance action: fetchUserStatus executed.');
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/check/in',
        eventType: 'fetchUserStatus',
        metadata: {'status': 'executed'},
      );
    } catch (_) {}
  }

  void displayNotifications() {
    print('Governance action: displayNotifications executed.');
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/check/in',
        eventType: 'displayNotifications',
        metadata: {'status': 'executed'},
      );
    } catch (_) {}
  }

  void accessHelpResources() {
    print('Governance action: accessHelpResources executed.');
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/check/in',
        eventType: 'accessHelpResources',
        metadata: {'status': 'executed'},
      );
    } catch (_) {}
  }
}

// --- Provider ---
final pswCheckInScreenControllerProvider = StateNotifierProvider<PswCheckInScreenController, PswCheckInScreenState>((ref) {
  return PswCheckInScreenController(ref);
});

// --- View ---
class PswCheckInScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for user check-in, status display, notifications, and help resources, along with responsive design for multiple platforms.';

  @override
  List<String> get requiredComponents => const [
        'CheckInForm',
        'UserStatusCard',
        'NotificationBanner',
        'HelpSupportLink',
        'ActivitySummary',
      ];

  @override
  List<String> get requiredFunctions => const [
        'handleCheckIn',
        'fetchUserStatus',
        'displayNotifications',
        'accessHelpResources',
      ];

  const PswCheckInScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(pswCheckInScreenControllerProvider);
    final controller = ref.read(pswCheckInScreenControllerProvider.notifier);
    
    // Form fields controllers/selections
    const selectedShift = 'Morning Shift';
    const selectedLocation = 'North Care Facility';

    final isCheckedIn = state.status == 'Checked In';
    final isCheckingIn = state.status == 'Checking In';

    return Semantics(
      label: 'data-cy:pswcheckin-btn-checkin',
      container: true,
      child: Scaffold(
        key: const Key('pswcheckin-btn-checkin'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(
            label: 'data-cy:pswcheckin-btn-help',
            container: true,
            child: Container(
              child: Text(
                key: const Key('pswcheckin-btn-help'),
                'Psw Check In',
                style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
              ),
            ),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswcheckin-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('pswcheckin-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Check-In Status Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCheckedIn 
                              ? Colors.green 
                              : (isCheckingIn ? Colors.orange : Colors.grey),
                          boxShadow: [
                            if (isCheckedIn || isCheckingIn)
                              BoxShadow(
                                color: (isCheckedIn ? Colors.green : Colors.orange).withValues(alpha: 0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status: ${state.status}',
                              style: theme.typography.h4.copyWith(
                                color: theme.colors.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (isCheckedIn) ...[
                              const SizedBox(height: 4),
                              Text(
                                '${state.currentShift} @ ${state.currentLocation}',
                                style: theme.typography.bodySmall.copyWith(
                                  color: theme.colors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 2. Check-In Form (Only show when Checked Out)
                if (!isCheckedIn)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Shift Check-In',
                          style: theme.typography.h4.copyWith(
                            color: theme.colors.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Dropdown simulation for Shift
                        Text('Shift Selection', style: theme.typography.bodySmall),
                        const SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: theme.colors.background,
                            borderRadius: BorderRadius.circular(theme.radiusSm),
                            border: Border.all(color: theme.colors.border),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(selectedShift, style: theme.typography.bodyMedium),
                              const Icon(LucideIcons.chevronDown, size: 16),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Dropdown simulation for Location
                        Text('Branch / Location', style: theme.typography.bodySmall),
                        const SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: theme.colors.background,
                            borderRadius: BorderRadius.circular(theme.radiusSm),
                            border: Border.all(color: theme.colors.border),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(selectedLocation, style: theme.typography.bodyMedium),
                              const Icon(LucideIcons.chevronDown, size: 16),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            key: const Key('pswcheckin-btn-checkin'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colors.primary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: isCheckingIn 
                                ? null 
                                : () => controller.handleCheckIn(selectedShift, selectedLocation),
                            child: isCheckingIn
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : Text(
                                    'Check In Now',
                                    style: theme.typography.button.copyWith(color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // 2b. Check-Out Button (Only show when Checked In)
                if (isCheckedIn)
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      key: const Key('pswcheckin-btn-checkin'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => controller.handleCheckOut(),
                      child: Text(
                        'Check Out Shift',
                        style: theme.typography.button.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),

                // 3. Notification Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.primaryContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.bellRing, color: theme.colors.primary, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Note: Ensure your device location permissions are enabled for verification.',
                          style: theme.typography.bodySmall.copyWith(
                            color: theme.colors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 4. Quick Help resources
                Text(
                  'Quick Help & Resources',
                  style: theme.typography.h4.copyWith(
                    color: theme.colors.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  key: const Key('pswcheckin-btn-help'),
                  onTap: () => controller.accessHelpResources(),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(theme.radiusSm),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(LucideIcons.helpCircle, color: theme.colors.primary, size: 18),
                            const SizedBox(width: 10),
                            Text(
                              'Support Hotline & FAQs',
                              style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Icon(LucideIcons.chevronRight, size: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 5. Check-In History
                Text(
                  'Recent Check-In History',
                  style: theme.typography.h4.copyWith(
                    color: theme.colors.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...state.history.map((h) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                            h['shift'] ?? '',
                            style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            h['location'] ?? '',
                            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            h['date'] ?? '',
                            style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            h['action'] ?? '',
                            style: theme.typography.bodySmall.copyWith(
                              color: (h['action']?.contains('Check-In') ?? false) ? Colors.green : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
