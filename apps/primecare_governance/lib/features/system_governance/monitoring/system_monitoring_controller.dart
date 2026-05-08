import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'system_monitoring_model.dart';

part 'system_monitoring_controller.g.dart';

@riverpod
class SystemMonitoringController extends _$SystemMonitoringController {
  @override
  SystemMonitoringState build() {
    _loadMetrics();
    return const SystemMonitoringState();
  }

  Future<void> _loadMetrics() async {
    try {
      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 800));

      final mockData = {
        'cpuUsage': 42.5,
        'ramUsage': 68.1,
        'networkTraffic': '1.2 GB/s',
        'activeConnections': 1405,
        'services': [
          {'name': 'API Gateway', 'status': 'Operational'},
          {'name': 'Auth Service', 'status': 'Operational'},
          {'name': 'Database Cluster', 'status': 'Degraded'},
          {'name': 'Worker Nodes', 'status': 'Operational'},
        ],
      };

      state = state.copyWith(isLoading: false, metrics: mockData);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load monitoring data',
      );
    }
  }

  void refreshMetrics() {
    state = state.copyWith(isLoading: true, error: null);
    _loadMetrics();
  }
}
