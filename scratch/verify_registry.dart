import 'apps/primecare_governance/lib/core/governance/screen_registry.dart';
import 'packages/factory_system/primecare_ui/lib/src/shared/src/integration/platform_governance_registry.dart';

void main() {
  print('--- Architectural Registry Audit ---');
  print('Platform Target Screens: ${PlatformGovernanceRegistry.totalScreens}');
  print('Local Registered Screens: ${ScreenRegistry.screens.length}');
  
  final missing = PlatformGovernanceRegistry.totalScreens - ScreenRegistry.screens.length;
  if (missing > 0) {
    print('STATUS: DRIFT DETECTED ($missing screens missing)');
  } else {
    print('STATUS: SYNCHRONIZED');
  }
}
