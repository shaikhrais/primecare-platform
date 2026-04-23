import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_cto_dashboard_screen.dart';

/// The high-fidelity intent for the CTO Command Horizon.
/// This intent specifically targets the Obsidian Lens aesthetic and handles its own build logic.
class CtoDashboardIntent extends PrimeCareScreen {
  CtoDashboardIntent() : super(
    name: 'cto',
    title: 'Systems & Architecture',
    subtitle: 'Infrastructure health and API performance monitoring.',
    requiredRole: PlatformRole.cto,
    provider: ctoDashboardAdapterProvider,
    route: CorporateRoutes.ctoDashboard,
    componentLabels: ['Command Horizon Header', 'Briefing Panel', 'System Health Cards', 'Security Audit Log', 'Architectural Load'],
  );

  @override
  Widget build(BuildContext context) => const CtoDashboardScreen();
}
