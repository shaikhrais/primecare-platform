part of '../../../aura_pulse_service.dart';

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
        if (_random.nextDouble() > 0.8) {
          _emitPredictiveEvent();
        } else if (_random.nextDouble() > 0.7) {
          _checkGovernanceDrift();
        } else if (_random.nextDouble() > 0.6) {
          _trackHydrationMetrics();
        } else if (_random.nextDouble() > 0.5) {
          _emitAnomaly();
        } else {
          telemetry.passGate(
            ExecutionGateCategory.auraEngine,
            'Aura Pulse Stable',
            silent: true,
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
        title: 'aura.events.critical_occupancy_title',
        description: 'aura.events.critical_occupancy_desc',
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
        title: 'aura.events.revenue_variance_title',
        description: 'aura.events.revenue_variance_desc',
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
        title: 'aura.events.efficiency_opt_title',
        description: 'aura.events.efficiency_opt_desc',
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

  void _emitPredictiveEvent() {
    final typeValue = _random.nextDouble();
    late AuraEvent event;

    if (typeValue > 0.5) {
      event = AuraEvent(
        id: 'pred_staff_${DateTime.now().millisecondsSinceEpoch}',
        type: AuraEventType.predictedStaffingGap,
        title: 'aura.events.staffing_gap_title',
        description: 'aura.events.staffing_gap_desc',
        impact: InsightImpact.caution,
        timestamp: DateTime.now(),
        isPredictive: true,
      );
    } else {
      event = AuraEvent(
        id: 'pred_budget_${DateTime.now().millisecondsSinceEpoch}',
        type: AuraEventType.predictedBudgetOverrun,
        title: 'aura.events.budget_overrun_title',
        description: 'aura.events.budget_overrun_desc',
        impact: InsightImpact.caution,
        timestamp: DateTime.now(),
        isPredictive: true,
      );
    }

    _ref
        .read<ExecutionGateService>(executionGateProvider)
        .passGate(
          ExecutionGateCategory.aura,
          'Aura PREDICTIVE Event Emitted: ${event.title}',
          metadata: {'id': event.id, 'isPredictive': true},
        );

    _controller.add(event);
  }

  void _checkGovernanceDrift() {
    // Governance blueprint auditing has been disabled.
    // In the future, we could check domain audit metrics here instead.
  }

  void _trackHydrationMetrics() {
    final result = PlatformGovernanceAudit.performAudit(_ref);
    final isHealthy = result.integrityScore >= 100.0;

    final event = AuraEvent(
      id: 'hydr_${DateTime.now().millisecondsSinceEpoch}',
      type: AuraEventType.hydrationMetrics,
      title: isHealthy
          ? 'aura.events.hydration_healthy_title'
          : 'aura.events.hydration_incomplete_title',
      description: isHealthy
          ? 'aura.events.hydration_healthy_desc'
          : 'aura.events.hydration_incomplete_desc',
      impact: isHealthy ? InsightImpact.positive : InsightImpact.caution,
      timestamp: DateTime.now(),
      metadata: {
        'score': result.integrityScore,
        'realized': result.realizedRoles.length,
        'pending': result.pendingRoles.length,
        'orphans': result.orphans.length,
      },
    );

    _ref
        .read<ExecutionGateService>(executionGateProvider)
        .passGate(
          ExecutionGateCategory.auraEngine,
          isHealthy
              ? 'Hydration Metric: 100% (55/55)'
              : 'Hydration Incomplete: ${result.integrityScore}%',
          silent: isHealthy,
          metadata: {
            'score': result.integrityScore,
            'realized': result.realizedRoles.length,
            'pending': result.pendingRoles.length,
          },
        );

    _controller.add(event);
  }
}
