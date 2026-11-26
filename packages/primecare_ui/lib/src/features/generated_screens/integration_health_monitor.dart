// Existing registered screen; provider configuration remains unavailable.
// PRIME:LOGIC=LOGIC_NONE PRIME:API=API_NONE PRIME:FINAL=FINAL_NOT_READY
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/registry/intents/app_screen_intent.dart';
import '../../communications/unavailable_configuration_screen.dart';

// Preserve the compatibility provider, but never fabricate an API or success.
final integration_health_monitorDataProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  throw UnimplementedGovernanceException('integration_health_monitor', 'provider configuration');
}, retry: (_, __) => null);

class IntegrationHealthMonitorScreen extends UnavailableConfigurationScreen {
  const IntegrationHealthMonitorScreen({super.key}) : super(screenCode: 'integration_health_monitor');
}
