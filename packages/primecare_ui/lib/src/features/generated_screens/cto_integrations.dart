// Existing registered screen; provider configuration remains unavailable.
// PRIME:LOGIC=LOGIC_NONE PRIME:API=API_NONE PRIME:FINAL=FINAL_NOT_READY
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/registry/intents/app_screen_intent.dart';
import '../../communications/unavailable_configuration_screen.dart';

// Preserve the compatibility provider, but never fabricate an API or success.
final cto_integrationsDataProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  throw UnimplementedGovernanceException('cto_integrations', 'provider configuration');
});

class CtoIntegrationsScreen extends UnavailableConfigurationScreen {
  const CtoIntegrationsScreen({super.key}) : super(screenCode: 'cto_integrations');
}
