import 'dart:async';

class ControlledTimer implements Timer {
  final Duration duration;
  final bool periodic;
  final void Function(Timer) callback;
  bool _active = true;
  int _tick = 0;
  ControlledTimer(this.duration, this.periodic, this.callback);
  void fire() {
    if (!_active) return;
    _tick++;
    if (!periodic) _active = false;
    callback(this);
  }

  @override
  void cancel() => _active = false;
  @override
  bool get isActive => _active;
  @override
  int get tick => _tick;
}

void withTimers(void Function(List<ControlledTimer>) run) {
  final timers = <ControlledTimer>[];
  runZoned(
    () => run(timers),
    zoneSpecification: ZoneSpecification(
      createTimer: (self, parent, zone, duration, callback) {
        final timer = ControlledTimer(duration, false, (_) => callback());
        timers.add(timer);
        return timer;
      },
      createPeriodicTimer: (self, parent, zone, duration, callback) {
        final timer = ControlledTimer(duration, true, callback);
        timers.add(timer);
        return timer;
      },
    ),
  );
}
