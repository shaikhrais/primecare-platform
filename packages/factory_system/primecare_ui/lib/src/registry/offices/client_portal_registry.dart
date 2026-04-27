// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
import 'base_office_registry.dart';

class ClientPortalRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(
      ClientRoutes.clientDashboard,
      PrimeCareForm.clientDashboard,
      componentLabels: [
        'Aura HUD',
        'Health Snapshot',
        'Appointment Calendar',
        'Care Team Messaging',
      ],
      structuralPlan:
          'Patient Empowerment Portal: Aura HUD with medication reminders. High-visibility health snapshot cards followed by appointment management and care team communication channels.',
    );
    registerRoute(
      ClientRoutes.familyMemberDashboard,
      PrimeCareForm.familyMemberDashboard,
      componentLabels: [
        'Aura HUD (Care Coordination)',
        'Patient Status Card',
        'Care Log Timeline',
        'Wellness Trend Chart',
      ],
      structuralPlan:
          'Family Vigilance Portal: Aura HUD with real-time patient status telemetry. Centered around a care log timeline and wellness trend visualization.',
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'client': {
      'title': 'client_portal.client.dashboard.title',
      'subtitle': 'client_portal.client.dashboard.subtitle',
      'route': ClientRoutes.clientDashboard,
      'componentLabels': [
        'Aura HUD',
        'Health Snapshot',
        'Appointment Calendar',
        'Care Team Messaging',
      ],
      'structuralPlan':
          'Patient Empowerment Portal: Aura HUD with medication reminders. High-visibility health snapshot cards followed by appointment management and care team communication channels.',
      'kpis': [
        {
          'title': 'Next Appointment',
          'value': 'Oct 24',
          'deltaSuffix': '10:00 AM',
          'icon': 'calendar',
          'iconColor': 'blue',
        },
      ],
    },
    'family_member': {
      'title': 'client_portal.family_member.dashboard.title',
      'subtitle': 'client_portal.family_member.dashboard.subtitle',
      'route': ClientRoutes.familyMemberDashboard,
      'componentLabels': [
        'Aura HUD (Care Coordination)',
        'Patient Status Card',
        'Care Log Timeline',
        'Wellness Trend Chart',
      ],
      'structuralPlan':
          'Family Vigilance Portal: Aura HUD with real-time patient status telemetry. Centered around a care log timeline and wellness trend visualization.',
      'kpis': [
        {
          'title': 'Recent Update',
          'value': '2h ago',
          'deltaSuffix': 'Stable Status',
          'icon': 'heart',
          'iconColor': 'red',
        },
      ],
    },
  };
}
