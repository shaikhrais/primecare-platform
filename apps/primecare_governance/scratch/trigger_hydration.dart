import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_governance/features/proposal_governance/services/blueprint_hydration_service.dart';

void main() async {
  final container = ProviderContainer();
  final service = container.read(blueprintHydrationServiceProvider);

  print('Starting Platform Registry Hydration...');
  final results = await service.hydrateFromBlueprints();

  print('Hydration Results:');
  results.forEach((key, value) {
    print(' - $key: $value');
  });
}
