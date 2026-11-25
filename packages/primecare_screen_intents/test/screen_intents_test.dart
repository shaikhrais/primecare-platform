import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_screen_intents/primecare_screen_intents.dart';
class FixtureIntent extends AppScreenIntent { @override String get name=>'sample_intent'; @override String get title=>'Fixture'; @override Widget build(BuildContext context)=>const SizedBox.shrink(); }
void main() { test('intent defaults preserve policy and readiness', () { final intent=FixtureIntent(); expect(intent.intentId,'sample-intent'); expect(intent.resiliencePolicy.maxRetries,3); expect(intent.verifyReady(null).isReady,isTrue); }); }
