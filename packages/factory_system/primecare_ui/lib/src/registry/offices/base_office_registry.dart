// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';

abstract class OfficeScreenRegistry {
  /// Defines hardcoded role-based routing
  void bootstrap();

  /// Defines dynamic dashboard configuration
  Map<String, Map<String, dynamic>> get registryJson;

  /// Helper to register screen using generic blueprint and form
  void registerRoute(String route, PrimeCareForm form, {List<String>? componentLabels}) {
    final roleName = route
            .split('/')
            .where((s) =>
                s.isNotEmpty &&
                s != 'offices' &&
                s != 'roles' &&
                s != 'dashboard' &&
                s != 'infrastructure')
            .firstOrNull ??
        'guest';

    ScreenRegistry.registerScreen(
      PrimeCareScreen(
        name: roleName,
        title: form.label,
        route: route,
        requiredRole: PlatformRole.fromRoute(route),
        provider: genericDashboardAdapterProvider(form),
        blueprints: const <UIComponentBlueprint>[
          AuraDashboardHudBlueprint(),
          StatGridBlueprint(dataPayload: <dynamic>[]),
        ],
        componentLabels: componentLabels ?? ['Aura HUD', 'KPI Stat Grid'],
      ),
    );
  }

  /// Helper to register customized high-fidelity dashboards
  void registerCustomDashboard(String route, String title, String pid, {List<String>? componentLabels}) {
    ScreenRegistry.registerScreen(
      PrimeCareScreen(
        name: pid,
        title: title,
        route: route,
        provider: genericDashboardAdapterProvider(
          PrimeCareForm.fromString(pid) ?? PrimeCareForm.genericDashboard,
        ),
        blueprints: const <UIComponentBlueprint>[
          AuraDashboardHudBlueprint(),
          StatGridBlueprint(dataPayload: <dynamic>[]),
        ],
        componentLabels: componentLabels ?? ['Aura HUD', 'Custom Stat Grid'],
      ),
    );
  }
}
