import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/platform_governance_audit.dart';

void main() {
  final container = ProviderContainer();

  print('=========================================');
  print('PRIMECARE PLATFORM GOVERNANCE AUDIT');
  print('=========================================');

  final result = PlatformGovernanceAudit.performAudit(container);

  print(result.toString());
  print('=========================================');
  print('REALIZED ROLES:');
  for (final role in result.realizedRoles) {
    final health = result.healthReports[role];
    final healthIcon = health?.isReady == true ? '✅' : '❌';
    print(' $healthIcon $role');
  }

  print('\nPENDING ROLES:');
  for (final role in result.pendingRoles) {
    print(' ⏳ $role');
  }
  print('=========================================');
}
