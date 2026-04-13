import 'dart:async';
import 'dart:math' as math;
import 'package:primecare_core/primecare_core.dart';

class AuraPulseService {
  final _controller = StreamController<AuraEvent>.broadcast();
  Timer? _heartbeatTimer;
  final _random = math.Random();

  Stream<AuraEvent> get pulse => _controller.stream;

  void start() {
    _heartbeatTimer?.cancel();

    // Emit a stable heartbeat every 10 seconds
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (_random.nextDouble() > 0.7) {
        _emitAnomaly();
      } else {
        _controller.add(AuraEvent.stable());
      }
    });

    // Initial signal
    _controller.add(AuraEvent.stable());
  }

  void stop() {
    _heartbeatTimer?.cancel();
    _controller.close();
  }

  void _emitAnomaly() {
    final impactValue = _random.nextDouble();

    if (impactValue > 0.8) {
      // Critical Anomaly
      _controller.add(
        AuraEvent(
          id: 'crit_${DateTime.now().millisecondsSinceEpoch}',
          type: AuraEventType.occupancySpike,
          title: 'Critical Occupancy Spike',
          description:
              'Facility at 98% capacity. Immediate discharge planning and staffing reallocation required.',
          impact: InsightImpact.alert,
          timestamp: DateTime.now(),
        ),
      );
    } else if (impactValue > 0.4) {
      // Caution Anomaly
      _controller.add(
        AuraEvent(
          id: 'caut_${DateTime.now().millisecondsSinceEpoch}',
          type: AuraEventType.revenueDip,
          title: 'Revenue Variance Detected',
          description:
              'Detected a 12% dip in projected daily billing. Auditing transaction logs...',
          impact: InsightImpact.caution,
          timestamp: DateTime.now(),
        ),
      );
    } else {
      // Info Anomaly
      _controller.add(
        AuraEvent(
          id: 'info_${DateTime.now().millisecondsSinceEpoch}',
          type: AuraEventType.workforceEfficiency,
          title: 'Efficiency Optimization',
          description:
              'Shift change documentation cycle completed 4 minutes faster than institutional baseline.',
          impact: InsightImpact.positive,
          timestamp: DateTime.now(),
        ),
      );
    }
  }
}
