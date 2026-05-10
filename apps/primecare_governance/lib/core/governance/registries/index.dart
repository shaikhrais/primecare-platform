import 'package:flutter_core/flutter_core.dart';
import 'core_governance_registry.dart';

class Registry {
  static Map<String, ScreenMetadata> get screens {
    return {...CoreGovernanceRegistry.screens};
  }
}
