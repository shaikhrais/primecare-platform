import 'base_result_service.dart';

/// Shared service parent retaining the platform's injected telemetry instance.
abstract class BaseTelemetryService<TTelemetry> extends BaseResultService {
  final TTelemetry telemetry;
  BaseTelemetryService(this.telemetry);
}
