// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_guest_dashboard_screen.dart';

class GuestDashboardIntent extends AppScreenIntent {
  GuestDashboardIntent();

  @override
  String get name => 'guest_dashboard';

  @override
  String get route => '/offices/corporate/roles/guest/dashboard';

  @override
  String get title => 'dashboards.guest.title';

  @override
  PlatformRole get requiredRole => PlatformRole.guest;

  @override
  dynamic get provider => guestDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const GuestDashboardScreen();
}
