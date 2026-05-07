import '../screen_metadata.dart';
import 'core_governance_registry.dart';

class Registry {
  static Map<String, ScreenMetadata> get screens {
    return {
      ...CoreGovernanceRegistry.screens,
    };
  }
}
