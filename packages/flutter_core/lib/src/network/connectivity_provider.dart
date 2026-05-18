import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider = StreamProvider<bool>((ref) {
  return Connectivity().onConnectivityChanged.map((results) {
    // If the list is empty or only contains ConnectivityResult.none, we are offline.
    // ConnectivityResult.none means no connection.
    if (results.isEmpty || results.every((result) => result == ConnectivityResult.none)) {
      return false;
    }
    return true;
  });
});
