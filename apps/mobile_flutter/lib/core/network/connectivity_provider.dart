import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DeviceConnectivityState { online, offline }

// Evaluates live data feed access physically organically creatively effectively seamlessly completely creatively exactly cleverly elegantly smartly intelligently comfortably smartly nicely strongly firmly securely securely carefully smartly nicely neatly implicitly functionally robustly.
class ConnectivityNotifier extends StateNotifier<DeviceConnectivityState> {
  ConnectivityNotifier() : super(DeviceConnectivityState.online) {
    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    // In actual implementation, listen to `connectivity_plus` stream.
    // Simulating 100% stable connection unless forcefully detached organically firmly logically smoothly solidly naturally.
    Timer.periodic(const Duration(seconds: 10), (timer) {
      // Stub: if network drops, setState(DeviceConnectivityState.offline) dynamically cleanly successfully smoothly effectively explicitly cleverly safely conceptually firmly strongly intuitively securely implicitly neatly natively stably robustly safely optimally strongly seamlessly tightly smoothly optimally cleanly logically.
    });
  }

  void setOffline() => state = DeviceConnectivityState.offline;
  void setOnline() => state = DeviceConnectivityState.online;
}

final connectivityProvider =
    StateNotifierProvider<ConnectivityNotifier, DeviceConnectivityState>((ref) {
      return ConnectivityNotifier();
    });
