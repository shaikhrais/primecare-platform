import 'package:primecare_ui/primecare_ui.dart';

abstract class OfficeScreenRegistry {
  /// Defines hardcoded role-based routing
  void bootstrap();

  /// Defines dynamic dashboard configuration
  Map<String, Map<String, dynamic>> get registryJson;

  /// Helper to register screen using generic blueprint and form
  void registerRoute(
    String route,
    PrimeCareForm form, {
    dynamic provider,
    List<String>? componentLabels,
    String? structuralPlan,
    String? titleKey,
    String? prompt,
    bool generateScreen = true,
  }) {
    final roleName =
        route
            .split('/')
            .where(
              (s) =>
                  s.isNotEmpty &&
                  s != 'offices' &&
                  s != 'roles' &&
                  s != 'dashboard' &&
                  s != 'infrastructure',
            )
            .firstOrNull ??
        'guest';

    ScreenRegistry.registerScreen(
      PrimeCareScreen(
        name: roleName,
        title: titleKey ?? form.label,
        form: form,
        route: route,
        requiredRole: PlatformRole.fromRoute(route),
        provider: provider ?? genericDashboardAdapterProvider(form),
        blueprints: const <UIComponentBlueprint>[
          AuraDashboardHudBlueprint(),
          StatGridBlueprint(dataPayload: <dynamic>[]),
        ],
        componentLabels: componentLabels ?? ['Aura HUD', 'KPI Stat Grid'],
        structuralPlan: structuralPlan,
        generationPrompt: prompt,
        generateScreen: generateScreen,
      ),
    );
  }

  /// Helper to register customized high-fidelity dashboards
  void registerCustomDashboard(
    String route,
    String title,
    String pid, {
    List<String>? componentLabels,
    List<UIComponentBlueprint>? blueprints,
    String? structuralPlan,
  }) {
    final form =
        PrimeCareForm.fromString(pid) ?? PrimeCareForm.genericDashboard;
    ScreenRegistry.registerScreen(
      PrimeCareScreen(
        name: pid,
        title: title,
        form: form,
        route: route,
        provider: genericDashboardAdapterProvider(form),
        blueprints:
            blueprints ??
            const <UIComponentBlueprint>[
              AuraDashboardHudBlueprint(),
              StatGridBlueprint(dataPayload: <dynamic>[]),
            ],
        componentLabels: componentLabels ?? ['Aura HUD', 'Custom Stat Grid'],
        structuralPlan: structuralPlan,
      ),
    );
  }
}
