import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_models/src/models/result.dart';
import 'package:primecare_execution_gate/primecare_execution_gate.dart';

abstract class BaseGuardedService {
  final ExecutionGateService telemetry;
  BaseGuardedService(this.telemetry);
  Future<Result<T>> guard<T>(
    FutureOr<T> Function() computation, {
    FutureOr<T> Function(Object, StackTrace)? onError,
  }) => Result.guardFuture<T>(computation, onError: onError);
}

abstract class BasePreferenceService extends BaseGuardedService {
  final SharedPreferences preferences;
  BasePreferenceService(this.preferences, super.telemetry);
}
