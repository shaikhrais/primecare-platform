// Host retains the existing environment and test-credential binding.
import 'package:primecare_models/src/models/platform_role.dart';
import 'package:primecare_portal_state/models/governance_role.dart';
import '../config/test_credentials_registry.dart';

class GovernanceRole extends GovernanceRoleBase {
  GovernanceRole(PlatformRole role) : super(role);

  /// Exposes the current application environment mode (e.g. localTesting, staging, production)
  AppMode get currentAppMode => TestCredentialsRegistry.currentMode;

  /// Retrieves the standard test credentials for this role if running locally.
  /// This will intentionally throw a fatal error if accessed in production mode.
  TestCredential? get testCredential => TestCredentialsRegistry.getForRole(role);

}
