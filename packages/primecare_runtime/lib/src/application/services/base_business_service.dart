// Host retains the concrete authenticated transport binding.
import '../../network/api_client.dart';
import '../../resilience/execution_gate_service.dart';
import '../../infrastructure/repositories/base_api_repository.dart';
import 'package:primecare_guarded_service/primecare_guarded_service.dart';
export 'package:primecare_guarded_service/primecare_guarded_service.dart';

abstract class BaseBusinessService extends BaseBusinessServiceBase<ApiRepository, ApiClient> {
  BaseBusinessService(ApiClient client, ExecutionGateService telemetry)
    : super(ApiRepository(client), (repository) => repository.client, telemetry);
}
