import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_models/primecare_models.dart';
import 'package:primecare_resilience/primecare_resilience.dart';
class FixtureNotifier extends Notifier<String> with ResilientNotifierMixin<String> { @override String build()=>'initial'; }
void main() { test('hydration success and failure retain states', () async { final container=ProviderContainer();addTearDown(container.dispose);final provider=NotifierProvider<FixtureNotifier,String>(FixtureNotifier.new);final n=container.read(provider.notifier);await n.guardHydration<int>(fetch:() async=>const Success(7),onSuccess:(v)=>'$v',onError:(_)=>'error',loadingState:'loading');expect(container.read(provider),'7');await n.guardHydration<int>(fetch:() async=>Failure(StateError('fixture')),onSuccess:(v)=>'$v',onError:(_)=>'error',loadingState:'loading');expect(container.read(provider),'error'); }); }
