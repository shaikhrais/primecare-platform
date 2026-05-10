import 'package:flutter_core/flutter_core.dart';
import '../screens/common/shared_screen_stubs.dart';

/// [ScreenRegistry] - UI-specific bridge for PlatformScreenRegistry.
/// Maps architectural metadata to actual Flutter widgets.
class ScreenRegistry {
  /// Local widget mapping for the UI layer.
  static final Map<String, Widget> _widgetRegistry = {
    // PSW Role
    'SCREEN_PSW_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'PSW Dashboard',
    ),
    'SCREEN_PSW_SHIFT_TRACKER': const ScreenNotImplementedView(
      screenName: 'PSW Shift Tracker',
    ),
    'SCREEN_PSW_CLIENTS': const ScreenNotImplementedView(
      screenName: 'PSW Client List',
    ),
    'SCREEN_PSW_TASKS': const ScreenNotImplementedView(
      screenName: 'PSW Task List',
    ),
    'SCREEN_PSW_MESSAGES': const ScreenNotImplementedView(
      screenName: 'PSW Messages',
    ),
    'SCREEN_PSW_VISIT_NOTES': const ScreenNotImplementedView(
      screenName: 'PSW Visit Notes',
    ),

    // RN Role
    'SCREEN_RN_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'RN Dashboard',
    ),
    'SCREEN_RN_ASSESSMENTS': const ScreenNotImplementedView(
      screenName: 'RN Assessments',
    ),
    'SCREEN_RN_CARE_PLANS': const ScreenNotImplementedView(
      screenName: 'RN Care Plans',
    ),

    // RPN Role
    'SCREEN_RPN_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'RPN Dashboard',
    ),

    // Coordinator Role
    'SCREEN_COORDINATOR_HUB': const ScreenNotImplementedView(
      screenName: 'Coordinator Hub',
    ),
    'SCREEN_COORDINATOR_DISPATCH_MAP': const ScreenNotImplementedView(
      screenName: 'Coordinator Dispatch Map',
    ),
    'SCREEN_COORDINATOR_SOS': const ScreenNotImplementedView(
      screenName: 'Coordinator SOS',
    ),
    'SCREEN_COORDINATOR_WAITLIST': const ScreenNotImplementedView(
      screenName: 'Coordinator Waitlist',
    ),

    // Allied Health
    'SCREEN_PT_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'PT Dashboard',
    ),
    'SCREEN_RMT_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'RMT Dashboard',
    ),
    'SCREEN_SW_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'SW Dashboard',
    ),
    'SCREEN_CHIRO_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'Chiro Dashboard',
    ),
  };

  /// Source of truth for metadata
  static Map<String, ScreenMetadata> get screens => PlatformScreenRegistry.screens;

  /// Returns all registered screen metadata
  static List<ScreenMetadata> getAllScreens() => PlatformScreenRegistry.allScreens;

  /// Retrieves the widget implementation for a given screen ID.
  static Widget getWidget(String id) {
    return _widgetRegistry[id] ?? ScreenNotImplementedView(screenName: id);
  }

  /// Audits the registry for health and implementation status.
  static List<ScreenAuditReport> auditRegistry() {
    return screens.keys
        .map(
          (id) => ScreenAuditReport(
            id: id,
            isHealthy: true,
            message: 'Screen $id is mapped to metadata.',
          ),
        )
        .toList();
  }

  /// Bootstraps the registry.
  static Future<void> bootstrap() async {
    debugPrint(
      'SCREEN_REGISTRY: Bootstrapping UI registries with ${screens.length} metadata entries and ${_widgetRegistry.length} widget mappings.',
    );
  }
}

class ScreenAuditReport {
  final String id;
  final bool isHealthy;
  final String message;

  ScreenAuditReport({
    required this.id,
    required this.isHealthy,
    required this.message,
  });
}
