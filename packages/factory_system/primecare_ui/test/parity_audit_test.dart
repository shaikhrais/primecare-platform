import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/governance_bootstrapper.dart';
import 'package:flutter_core/flutter_core.dart';

void main() {
  test('Governance Registry Parity Audit', () {
    GovernanceBootstrapper.bootstrap();
    
    final intents = GovernanceRegistry.getAllIntents();
    final missingForm = <String>[];
    final missingProvider = <String>[];
    
    for (final intent in intents) {
      if (intent is PrimeCareScreen) {
        if (intent.form == null) {
          missingForm.add('${intent.runtimeType} (${intent.route})');
        }
        if (intent.provider == null) {
          missingProvider.add('${intent.runtimeType} (${intent.route})');
        }
      }
    }

    expect(missingForm, isEmpty, reason: 'All dashboards must have a PrimeCareForm binding.');
    expect(missingProvider, isEmpty, reason: 'All dashboards must have a data provider binding.');
  });
}
