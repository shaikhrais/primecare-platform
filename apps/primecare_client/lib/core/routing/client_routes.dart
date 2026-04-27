import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import '../../features/client_operations/client_operations_view.dart';

class ScreenConfig {
  final String routePath;
  final String titleKey;
  final String subtitleKey;
  final String providerId;
  final Widget? customView;

  const ScreenConfig({
    required this.routePath,
    required this.titleKey,
    required this.subtitleKey,
    required this.providerId,
    this.customView,
  });
}

final List<ScreenConfig> clientScreenRegistry = [
  const ScreenConfig(
    routePath: ClientRoutes.patientDashboard,
    titleKey: 'Patient Dashboard',
    subtitleKey: 'Manage your care plan.',
    providerId: 'patientDashboard',
    customView: PatientDashboardView(),
  ),
  const ScreenConfig(
    routePath: ClientRoutes.familyMemberDashboard,
    titleKey: 'Family Dashboard',
    subtitleKey: 'Loved one care updates.',
    providerId: 'familyDashboard',
    customView: FamilyDashboardView(),
  ),
];

final List<RouteBase> clientRoutes = [
  ...clientScreenRegistry.map((config) => GoRoute(
        path: config.routePath,
        builder: (context, state) => config.customView ?? GenericClientView(
          title: config.titleKey,
          subtitle: config.subtitleKey,
          providerId: config.providerId,
        ),
      )),
];

