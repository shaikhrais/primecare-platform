import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';
import 'support/controlled_timers.dart';

class Recovery extends BaseRecoveryManager {
  final messages = <String>[];
  Recovery({super.clock});
  @override
  void log(String message) => messages.add(message);
}

void main() {
  test('reset is delayed and crash velocity blocks additional attempts', () {
    withTimers((timers) {
      var now = DateTime.utc(2026);
      final recovery = Recovery(clock: () => now);
      var resets = 0;
      expect(recovery.attemptAutoHeal(() => resets++), isTrue);
      expect(recovery.healCount, 1);
      expect(resets, 0);
      expect(timers.single.duration, const Duration(milliseconds: 500));
      now = now.add(const Duration(milliseconds: 4999));
      expect(recovery.attemptAutoHeal(() => resets++), isFalse);
      expect(timers, hasLength(1));
      timers.single.fire();
      expect(resets, 1);
      now = now.add(const Duration(milliseconds: 1));
      expect(recovery.attemptAutoHeal(null), isTrue);
      timers.last.fire();
      expect(recovery.healCount, 2);
      expect(resets, 1);
    });
  });
  test('maximum attempts and stable reset preserve shared configuration', () {
    final previous = ResilienceConfig.maxAutoResets;
    try {
      ResilienceConfig.maxAutoResets = 2;
      withTimers((timers) {
        var now = DateTime.utc(2026);
        final recovery = Recovery(clock: () => now);
        expect(recovery.attemptAutoHeal(null), isTrue);
        now = now.add(const Duration(seconds: 5));
        expect(recovery.attemptAutoHeal(null), isTrue);
        now = now.add(const Duration(seconds: 5));
        expect(recovery.attemptAutoHeal(null), isFalse);
        expect(recovery.healCount, 2);
        expect(timers, hasLength(2));
        recovery.markStable();
        expect(recovery.healCount, 0);
        expect(recovery.attemptAutoHeal(null), isTrue);
        for (final timer in timers) {
          timer.fire();
        }
      });
    } finally {
      ResilienceConfig.maxAutoResets = previous;
    }
  });
  test('stable reset does not cancel an already scheduled callback', () {
    withTimers((timers) {
      final recovery = Recovery();
      var resets = 0;
      recovery.markStable();
      expect(recovery.messages, isEmpty);
      recovery.attemptAutoHeal(() => resets++);
      recovery.markStable();
      timers.single.fire();
      expect(resets, 1);
      expect(recovery.healCount, 0);
    });
  });
}
