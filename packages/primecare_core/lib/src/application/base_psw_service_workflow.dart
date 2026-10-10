import 'package:primecare_models/primecare_models.dart';
import 'base_result_service.dart';
import '../network/base_api_transport.dart';

abstract class BasePswServiceWorkflow<T extends BaseApiTransport>
    extends BaseResultService {
  final T _api;

  BasePswServiceWorkflow(this._api);

  Future<Result<PswDashboardData>> getDashboardData() async {
    return guard<PswDashboardData>(() async {
      final response = await _api.get('/psw/dashboard');
      return PswDashboardData.fromJson(response.data as Map<String, dynamic>);
    });
  }

  // Placeholder for other PSW screens
  Future<Result<List<PswClient>>> getClients() async {
    return guard<List<PswClient>>(() async {
      final response = await _api.get('/psw/clients');
      return (response.data as List)
          .map((c) => PswClient.fromJson(c as Map<String, dynamic>))
          .toList();
    });
  }

  Future<Result<List<PswTask>>> getTasks() async {
    return guard<List<PswTask>>(() async {
      final response = await _api.get('/psw/tasks');
      return (response.data as List)
          .map((t) => PswTask.fromJson(t as Map<String, dynamic>))
          .toList();
    });
  }
}
