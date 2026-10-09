import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/api_client.dart';
import '../../resilience/result.dart';
import '../../resilience/execution_gate_service.dart';
import '../../infrastructure/repositories/base_api_repository.dart';

abstract class BaseGuardedService {
  final ExecutionGateService telemetry;
  BaseGuardedService(this.telemetry);
  Future<Result<T>> guard<T>(
    FutureOr<T> Function() computation, {
    FutureOr<T> Function(Object, StackTrace)? onError,
  }) => Result.guardFuture<T>(computation, onError: onError);
}

abstract class BaseBusinessService extends BaseGuardedService {
  final ApiRepository repository;
  BaseBusinessService(ApiClient client, ExecutionGateService telemetry)
    : repository = ApiRepository(client),
      super(telemetry);
  ApiClient get apiClient => repository.client;
}

abstract class BasePreferenceService extends BaseGuardedService {
  final SharedPreferences preferences;
  BasePreferenceService(this.preferences, super.telemetry);
}
