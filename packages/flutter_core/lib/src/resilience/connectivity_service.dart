// Layer: 01_INFRASTRUCTURE
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// Tracks device connectivity state to prevent pointless API calls when offline.
///
/// Usage in providers:
/// ```dart
/// final isOnline = ref.watch(connectivityProvider);
/// if (!isOnline) return MyModel.offline();
/// ```
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final Ref _ref;

  bool _isOnline = true;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityService(this._ref);

  bool get isOnline => _isOnline;

  /// Initialize and start listening to connectivity changes.
  Future<void> initialize() async {
    // Check initial state
    final results = await _connectivity.checkConnectivity();
    _updateState(results);

    // Listen for changes
    _subscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  void _updateState(List<ConnectivityResult> results) {
    final wasOnline = _isOnline;
    _isOnline = results.any((r) => r != ConnectivityResult.none);

    if (wasOnline && !_isOnline) {
      _ref
          .read<ExecutionGateService>(executionGateProvider)
          .failGate(
            ExecutionGateCategory.network,
            'Device went OFFLINE. API calls will be skipped.',
            metadata: {'connectivity': results.map((r) => r.name).toList()},
          );
    } else if (!wasOnline && _isOnline) {
      _ref
          .read<ExecutionGateService>(executionGateProvider)
          .passGate(
            ExecutionGateCategory.network,
            'Device came ONLINE. Resuming API calls.',
            metadata: {'connectivity': results.map((r) => r.name).toList()},
          );
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}

/// Provides the current online/offline state as a reactive boolean.
/// Watch this in any provider to skip API calls when offline.
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService(ref);
  service.initialize();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Simple boolean provider for quick connectivity checks.
/// Returns true if the device has any network connection.
final isOnlineProvider = Provider<bool>((ref) {
  return ref.watch(connectivityServiceProvider).isOnline;
});
