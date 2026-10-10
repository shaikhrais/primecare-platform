import 'support/controlled_timers.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

void main() {
  test('one-shot refresh uses default interval and fires once', () {
    withTimers((timers) {
      var calls = 0;
      final disposers = <void Function()>[];
      RefreshLifecycle.autoInvalidate(
        invalidate: () => calls++,
        onDispose: disposers.add,
      );
      expect(timers.single.duration, const Duration(minutes: 5));
      expect(disposers, hasLength(1));
      timers.single.fire();
      timers.single.fire();
      expect(calls, 1);
      disposers.single();
      expect(timers.single.isActive, isFalse);
    });
  });
  test('disposing before first refresh cancels its timer', () {
    withTimers((timers) {
      var calls = 0;
      final disposers = <void Function()>[];
      RefreshLifecycle.autoInvalidate(
        invalidate: () => calls++,
        onDispose: disposers.add,
        duration: Duration.zero,
      );
      expect(timers.single.duration, Duration.zero);
      disposers.single();
      timers.single.fire();
      expect(calls, 0);
    });
  });
  test(
    'periodic refresh repeats until disposal and respects custom interval',
    () {
      withTimers((timers) {
        var calls = 0;
        final disposers = <void Function()>[];
        RefreshLifecycle.periodicRefresh(
          invalidate: () => calls++,
          onDispose: disposers.add,
          interval: const Duration(seconds: 17),
        );
        expect(timers.single.duration, const Duration(seconds: 17));
        timers.single.fire();
        timers.single.fire();
        expect(calls, 2);
        disposers.single();
        timers.single.fire();
        expect(calls, 2);
      });
    },
  );
  test(
    'separate owners retain independent timers and default periodic interval',
    () {
      withTimers((timers) {
        final disposers = <void Function()>[];
        var calls = 0;
        for (var i = 0; i < 2; i++) {
          RefreshLifecycle.periodicRefresh(
            invalidate: () => calls++,
            onDispose: disposers.add,
          );
        }
        expect(
          timers.map((t) => t.duration),
          everyElement(const Duration(minutes: 5)),
        );
        disposers.first();
        timers.first.fire();
        timers.last.fire();
        expect(calls, 1);
        disposers.last();
      });
    },
  );
}
