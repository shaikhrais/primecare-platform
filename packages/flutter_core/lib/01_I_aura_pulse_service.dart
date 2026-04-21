// Layer: 01_INFRASTRUCTURE
import 'dart:async';
import 'dart:math' as math;
import 'package:primecare_adapters/primecare_adapters.dart';
import 'src/models/02_M_aura_event.dart';

class AuraPulseService {
  final Ref _ref;
  final _controller = StreamController<AuraEvent>.broadcast();
  Timer? _heartbeatTimer;
  final _random = math.Random();

  AuraPulseService(this._ref);

  Stream<AuraEvent> get pulse => _controller.stream;

  void start() {
    _heartbeatTimer?.cancel();
    final telemetry = _ref.read<ExecutionGateService>(executionGateProvider);

    telemetry.passGate(
      ExecutionGateCategory.auraEngine,
      'Aura Heartbeat Service Started',
    );

    // Emit a stable heartbeat every 15 seconds
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (_controller.isClosed) {
        timer.cancel();
        return;
      }
      try {
        if (_random.nextDouble() > 0.7) {
          _emitAnomaly();
        } else {
          telemetry.passGate(
            ExecutionGateCategory.auraEngine,
            'Aura Pulse Stable',
          );
          _controller.add(AuraEvent.stable());
        }
      } catch (e, st) {
        telemetry.failGate(
          ExecutionGateCategory.auraEngine,
          'Aura Heartbeat Error',
          error: e,
          stackTrace: st,
        );
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
      final event = AuraEvent(
        id: 'crit_${DateTime.now().millisecondsSinceEpoch}',
        type: AuraEventType.occupancySpike,
        title: 'Critical Occupancy Spike',
        description:
            'Facility at 98% capacity. Immediate discharge planning and staffing reallocation required.',
        impact: InsightImpact.alert,
        timestamp: DateTime.now(),
      );

      _ref
          .read<ExecutionGateService>(executionGateProvider)
          .passGate(
            ExecutionGateCategory.aura,
            'Aura ALERT Event Emitted: ${event.title}',
            metadata: {'id': event.id, 'type': event.type.name},
          );

      _controller.add(event);
    } else if (impactValue > 0.4) {
      // Caution Anomaly
      final event = AuraEvent(
        id: 'caut_${DateTime.now().millisecondsSinceEpoch}',
        type: AuraEventType.revenueDip,
        title: 'Revenue Variance Detected',
        description:
            'Detected a 12% dip in projected daily billing. Auditing transaction logs...',
        impact: InsightImpact.caution,
        timestamp: DateTime.now(),
      );

      _ref
          .read<ExecutionGateService>(executionGateProvider)
          .passGate(
            ExecutionGateCategory.aura,
            'Aura Caution Event Emitted: ${event.title}',
            metadata: {'id': event.id, 'type': event.type.name},
          );

      _controller.add(event);
    } else {
      // Info Anomaly
      final event = AuraEvent(
        id: 'info_${DateTime.now().millisecondsSinceEpoch}',
        type: AuraEventType.workforceEfficiency,
        title: 'Efficiency Optimization',
        description:
            'Shift change documentation cycle completed 4 minutes faster than institutional baseline.',
        impact: InsightImpact.positive,
        timestamp: DateTime.now(),
      );

      _ref
          .read<ExecutionGateService>(executionGateProvider)
          .passGate(
            ExecutionGateCategory.auraEngine,
            'Aura Efficiency Event Emitted: ${event.title}',
            metadata: {'id': event.id},
          );

      _controller.add(event);
    }
  }
}
