// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Placeholder for other PSW screens
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_models/src/models/psw_models.dart';
import 'package:primecare_models/src/models/result.dart';

class PswServiceBase {
  final Future<dynamic> Function(String path) _read;

  PswServiceBase(this._read);

  Future<Result<PswDashboardData>> getDashboardData() async {
    return Result.guardFuture<PswDashboardData>(() async {
      final data = await _read('/psw/dashboard');
      return PswDashboardData.fromJson(data as Map<String, dynamic>);
    });
  }

  // Placeholder for other PSW screens
  Future<Result<List<PswClient>>> getClients() async {
    return Result.guardFuture<List<PswClient>>(() async {
      final data = await _read('/psw/clients');
      return (data as List)
          .map((c) => PswClient.fromJson(c as Map<String, dynamic>))
          .toList();
    });
  }

  Future<Result<List<PswTask>>> getTasks() async {
    return Result.guardFuture<List<PswTask>>(() async {
      final data = await _read('/psw/tasks');
      return (data as List)
          .map((t) => PswTask.fromJson(t as Map<String, dynamic>))
          .toList();
    });
  }
}

// Host composition provides the original authenticated API provider.
