import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_resilience/primecare_resilience.dart';

void main() {
  test('last-known-good snapshots are isolated by key and flushed', () async {
    final service = ResilienceService();
    await service.saveSnapshot('one', {'value': 3});
    expect(await service.getSnapshot('missing'), isNull);
    final recovered = await service.getSnapshot('one');
    expect(recovered, {'value': 3});
    recovered!['value'] = 5;
    expect(await service.getSnapshot('one'), {'value': 3});
    service.flush();
    expect(await service.getSnapshot('one'), isNull);
  });
  testWidgets('restart recreates state of the wrapped subtree', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: RestartWrapper(child: Scaffold(body: _Counter()))));
    await tester.tap(find.text('Increment'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.text('Restart'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });
  testWidgets('recovery stops rapid retries and invokes one reset', (tester) async {
    SystemRecoveryManager.markStable();
    addTearDown(SystemRecoveryManager.markStable);
    var resets = 0;
    expect(SystemRecoveryManager.attemptAutoHeal(() => resets++), isTrue);
    expect(SystemRecoveryManager.attemptAutoHeal(() => resets++), isFalse);
    await tester.pump(const Duration(milliseconds: 500));
    expect(resets, 1);
    expect(SystemRecoveryManager.healCount, 1);
    SystemRecoveryManager.markStable();
    expect(SystemRecoveryManager.healCount, 0);
  });
}
class _Counter extends StatefulWidget {
  const _Counter();
  @override State<_Counter> createState() => _CounterState();
}
class _CounterState extends State<_Counter> {
  int count = 0;
  @override Widget build(BuildContext context) => Column(children: [
    Text('$count'),
    TextButton(onPressed: () => setState(() => count++), child: const Text('Increment')),
    TextButton(onPressed: () => RestartWrapper.restartApp(context), child: const Text('Restart')),
  ]);
}
