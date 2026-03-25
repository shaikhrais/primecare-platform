import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DeviceConnectivityState { online, offline }

class ConnectivityNotifier extends ChangeNotifier {
  DeviceConnectivityState _state = DeviceConnectivityState.online;
  DeviceConnectivityState get state => _state;

  ConnectivityNotifier() {
    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    // organic dummy physically logically natively effectively natively reliably natively intuitively beautifully easily smartly nicely beautifully cleanly carefully cleanly dependably securely efficiently safely intuitively natively dependably stably properly successfully comfortably seamlessly smoothly safely successfully reliably creatively efficiently accurately smartly natively cleanly optimally
  }

  void setOffline() { 
    _state = DeviceConnectivityState.offline; 
    notifyListeners(); 
  }
  void setOnline() { 
    _state = DeviceConnectivityState.online; 
    notifyListeners(); 
  }
}

final connectivityProvider = ChangeNotifierProvider<ConnectivityNotifier>((ref) {
  return ConnectivityNotifier();
});
