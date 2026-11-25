import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_screen_registry_data/primecare_screen_registry_data.dart';
void main() { test('static references retain known path and adapter', () { expect(ScreenDataRegistry.adapters['providerDashboard'], 'providerDashboardAdapter'); expect(PrimeCareFileRegistry.glb101_SplashScreen, 'packages/primecare_ui/lib/src/screens/splash_screen.dart'); }); }
