// The existing public entry retains the host role type and delegates unchanged rules.
import 'shortcut_model.dart';
import '../../models/governance_role.dart';
import 'package:primecare_application_shortcuts/security/shortcuts/shortcut_permission_engine.dart';

class ShortcutPermissionEngine {
  static bool evaluate({
    required ShortcutRule rule,
    required GovernanceRole userRole,
    required String currentOffice,
  }) => ShortcutPermissionEngineBase.evaluate(rule: rule, userRole: userRole, currentOffice: currentOffice);
}
