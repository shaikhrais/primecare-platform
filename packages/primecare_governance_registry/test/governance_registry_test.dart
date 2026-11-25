import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance_registry/primecare_governance_registry.dart';
import 'package:primecare_screen_intents/primecare_screen_intents.dart';
class FixtureIntent extends AppScreenIntent { @override String get name=>'fixture'; @override String get title=>'Fixture'; @override Widget build(BuildContext context)=>const SizedBox.shrink(); }
void main(){test('registry preserves intent identity and readiness',(){addTearDown(GovernanceRegistry.flush);final intent=FixtureIntent();GovernanceRegistry.register(intent);expect(GovernanceRegistry.getIntentByRoute(intent.route),same(intent));expect(GovernanceRegistry.performHealthSweep(null).single.isHealthy,isTrue);});}
