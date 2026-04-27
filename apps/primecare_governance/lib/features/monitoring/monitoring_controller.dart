import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/telemetry_service.dart';
import 'system_metric.dart';

class MonitoringState {
  final List<SystemMetric> cpuHistory;
  final List<SystemMetric> memoryHistory;
  final List<SystemMetric> requestHistory;

  MonitoringState({
    this.cpuHistory = const [],
    this.memoryHistory = const [],
    this.requestHistory = const [],
  });

  MonitoringState copyWith({
    List<SystemMetric>? cpuHistory,
    List<SystemMetric>? memoryHistory,
    List<SystemMetric>? requestHistory,
  }) {
    return MonitoringState(
      cpuHistory: cpuHistory ?? this.cpuHistory,
      memoryHistory: memoryHistory ?? this.memoryHistory,
      requestHistory: requestHistory ?? this.requestHistory,
    );
  }
}

class MonitoringController extends StateNotifier<MonitoringState> {
  MonitoringController(this.ref) : super(MonitoringState()) {
    _listenToTelemetry();
  }

  final Ref ref;
  static const int maxHistory = 30;

  void _listenToTelemetry() {
    ref.listen(systemHealthProvider, (previous, next) {
      next.whenData((data) {
        state = state.copyWith(
          cpuHistory: _updateHistory(state.cpuHistory, data.cpuUsage, data.timestamp),
          memoryHistory: _updateHistory(state.memoryHistory, data.memoryUsage, data.timestamp),
          requestHistory: _updateHistory(state.requestHistory, data.activeRequests.toDouble(), data.timestamp),
        );
      });
    });
  }

  List<SystemMetric> _updateHistory(List<SystemMetric> current, double newValue, DateTime timestamp) {
    final newList = List<SystemMetric>.from(current)..add(SystemMetric(timestamp: timestamp, value: newValue));
    if (newList.length > maxHistory) newList.removeAt(0);
    return newList;
  }
}

final monitoringControllerProvider = StateNotifierProvider<MonitoringController, MonitoringState>((ref) {
  return MonitoringController(ref);
});
