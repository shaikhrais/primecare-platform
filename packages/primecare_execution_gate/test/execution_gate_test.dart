import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_execution_gate/primecare_execution_gate.dart';
void main() { test('execution gate is stable within provider scope', () { final container=ProviderContainer(); addTearDown(container.dispose); final gate=container.read(executionGateProvider); expect(container.read(executionGateProvider),same(gate)); expect(()=>gate.passGate(ExecutionGateCategory.network,'fixture',silent:true),returnsNormally); }); }
