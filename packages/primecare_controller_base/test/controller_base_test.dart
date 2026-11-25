import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_controller_base/primecare_controller_base.dart';
class FixtureValue extends BaseValueNotifier<int> { @override int get initialValue => 0; }
class FixtureScaffold extends BaseScaffoldController {}
void main() {
  test('value updates and unimplemented scaffold remains unimplemented', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final value = NotifierProvider<FixtureValue, int>(FixtureValue.new);
    expect(container.read(value), 0);
    container.read(value.notifier).update(3);
    expect(container.read(value), 3);
    final scaffold = NotifierProvider<FixtureScaffold, AsyncValue<Map<String, dynamic>>>(FixtureScaffold.new);
    expect(container.read(scaffold).requireValue['featuresEnabled'], isFalse);
    await container.read(scaffold.notifier).performAction();
    expect(container.read(scaffold).hasError, isTrue);
  });
}
