import '../network/base_api_transport.dart';
import '../network/base_transport_repository.dart';
import 'base_execution_gate_service.dart';
import 'base_telemetry_service.dart';

/// Platform-neutral business ports; adapters retain authorization and transport.
abstract class BaseBusinessWorkflow<
  R extends BaseTransportRepository<BaseApiTransport>,
  T extends BaseExecutionGateService
>
    extends BaseTelemetryService<T> {
  final R repository;
  final Map<String, String> endpoints;
  BaseBusinessWorkflow(this.repository, T telemetry, this.endpoints)
    : super(telemetry);
  BaseApiTransport get apiClient => repository.client;
}
