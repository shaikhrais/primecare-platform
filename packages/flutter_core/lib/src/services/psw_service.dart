// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Placeholder for other PSW screens
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

class PswService {
  final ApiClient _api;

  PswService(this._api);

  Future<Result<PswDashboardData>> getDashboardData() async {
    return Result.guardFuture<PswDashboardData>(() async {
      final response = await _api.get('/psw/dashboard');
      return PswDashboardData.fromJson(response.data as Map<String, dynamic>);
    });
  }

  // Placeholder for other PSW screens
  Future<Result<List<PswClient>>> getClients() async {
    return Result.guardFuture<List<PswClient>>(() async {
      final response = await _api.get('/psw/clients');
      return (response.data as List)
          .map((c) => PswClient.fromJson(c as Map<String, dynamic>))
          .toList();
    });
  }

  Future<Result<List<PswTask>>> getTasks() async {
    return Result.guardFuture<List<PswTask>>(() async {
      final response = await _api.get('/psw/tasks');
      return (response.data as List)
          .map((t) => PswTask.fromJson(t as Map<String, dynamic>))
          .toList();
    });
  }
}

final pswServiceProvider = Provider<PswService>((ref) {
  final api = ref.watch(apiClientProvider);
  return PswService(api);
});
