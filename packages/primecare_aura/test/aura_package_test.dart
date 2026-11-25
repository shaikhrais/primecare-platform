import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_aura/primecare_aura.dart';
void main(){
  test('existing command interpretation and scalar state are preserved',(){
    final service=AuraCommandService();
    expect(service.processQuery('snooze alerts').getOrThrow().title,'Snooze Aura Alerts');
    final container=ProviderContainer();addTearDown(container.dispose);
    final query=NotifierProvider<AuraQueryNotifier,String>(AuraQueryNotifier.new);
    expect(container.read(query),'');container.read(query.notifier).update('fixture');expect(container.read(query),'fixture');
  });
}
