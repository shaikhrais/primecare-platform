import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/generated_screens/intake_pipeline.dart';

void main() {
 test('actual intake controller keeps injected references and state isolated per provider scope', () {
  final references=<Ref>[];
  final provider=StateNotifierProvider<IntakePipelineController,IntakePipelineState>((ref){references.add(ref);return IntakePipelineController(ref);});
  final first=ProviderContainer(),second=ProviderContainer();addTearDown(first.dispose);addTearDown(second.dispose);
  final a=first.read(provider.notifier),b=second.read(provider.notifier);
  expect(a.ref,same(references[0]));expect(b.ref,same(references[1]));expect(identical(a.ref,b.ref),isFalse);
  a.updateSearch('first account');expect(first.read(provider).searchQuery,'first account');expect(second.read(provider).searchQuery,'');
  b.updateSearch('second account');expect(first.read(provider).searchQuery,'first account');expect(second.read(provider).searchQuery,'second account');
 });
}
