import 'primecare_guarded_service.dart' show BaseGuardedService;

/// Common business service holds its injected repository and the existing guard.
abstract class BaseBusinessServiceBase<R, C> extends BaseGuardedService {
  final R repository;
  final C Function(R repository) _clientOf;
  BaseBusinessServiceBase(this.repository, this._clientOf, super.telemetry);
  C get apiClient => _clientOf(repository);
}
