// Layer: 01_INFRASTRUCTURE
import 'package:dio/dio.dart';
import 'api_client.dart';
import 'telemetry_service.dart';
import 'result.dart';

class TrainingService {
  final ApiClient _apiClient;
  final ExecutionGateService _telemetry;

  TrainingService(this._apiClient, this._telemetry);

  /// Fetches a summary of training compliance and certifications.
  Future<Result<Map<String, dynamic>>> getTrainingSummary() async {
    return Result.guardFuture<Map<String, dynamic>>(() async {
      final response = await _apiClient.get('/compliance/training/summary');
      if (response.statusCode == 200) {
        _telemetry.passGate(
          ExecutionGateCategory.metricsLayer,
          'Training compliance summary fetched',
        );
        final data = response.data as Map<String, dynamic>;
        return data['data'] as Map<String, dynamic>;
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    });
  }

  /// Lists all available training modules.
  Future<Result<List<Map<String, dynamic>>>> listModules() async {
    return Result.guardFuture<List<Map<String, dynamic>>>(() async {
      final response = await _apiClient.get('/compliance/training/modules');
      final dataList = response.data as List<dynamic>;
      return dataList.map((e) => e as Map<String, dynamic>).toList();
    });
  }

  /// Verifies a certificate against the internal registry.
  Future<Result<Map<String, dynamic>>> verifyCertificate(
    String staffName,
    String certName,
  ) async {
    return Result.guardFuture<Map<String, dynamic>>(() async {
      final response = await _apiClient.post(
        '/compliance/training/verify-certificate',
        body: {'staffName': staffName, 'certName': certName},
      );
      if (response.statusCode == 200) {
        _telemetry.passGate(
          ExecutionGateCategory.compliance,
          'Certificate verification performed for: $staffName',
        );
        return response.data as Map<String, dynamic>;
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    });
  }

  /// Fetches the recent activity feed for training and certifications.
  Future<Result<List<Map<String, dynamic>>>> getRecentActivity({
    int limit = 10,
  }) async {
    return Result.guardFuture<List<Map<String, dynamic>>>(() async {
      final response = await _apiClient.get(
        '/compliance/training/activity',
        query: {'limit': limit},
      );
      if (response.statusCode == 200) {
        final rawData = response.data as Map<String, dynamic>;
        final dataList = rawData['data'] as List<dynamic>;
        return dataList.map((e) => e as Map<String, dynamic>).toList();
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    });
  }

  /// Fetches all curricula for the tenant.
  Future<Result<List<Map<String, dynamic>>>> getCurricula() async {
    return Result.guardFuture<List<Map<String, dynamic>>>(() async {
      final response = await _apiClient.get('/compliance/training/curricula');
      if (response.statusCode == 200) {
        final rawData = response.data as Map<String, dynamic>;
        final dataList = rawData['data'] as List<dynamic>;
        return dataList.map((e) => e as Map<String, dynamic>).toList();
      }
      throw Exception('Failed to fetch curricula');
    });
  }

  /// Fetches all certifications for the tenant.
  Future<Result<List<Map<String, dynamic>>>> getCertifications() async {
    return Result.guardFuture<List<Map<String, dynamic>>>(() async {
      final response = await _apiClient.get(
        '/compliance/training/certifications',
      );
      if (response.statusCode == 200) {
        final rawData = response.data as Map<String, dynamic>;
        final dataList = rawData['data'] as List<dynamic>;
        return dataList.map((e) => e as Map<String, dynamic>).toList();
      }
      throw Exception('Failed to fetch certifications');
    });
  }

  /// Creates a new training module.
  Future<Result<Map<String, dynamic>>> createModule(
    Map<String, dynamic> data,
  ) async {
    return Result.guardFuture<Map<String, dynamic>>(() async {
      final response = await _apiClient.post(
        '/compliance/training/modules',
        body: data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final rawData = response.data as Map<String, dynamic>;
        return rawData['data'] as Map<String, dynamic>;
      }
      throw Exception('Failed to create module');
    });
  }

  /// Updates an existing training module.
  Future<Result<Map<String, dynamic>>> updateModule(
    String id,
    Map<String, dynamic> data,
  ) async {
    return Result.guardFuture<Map<String, dynamic>>(() async {
      final response = await _apiClient.put(
        '/compliance/training/modules/$id',
        body: data,
      );
      if (response.statusCode == 200) {
        final rawData = response.data as Map<String, dynamic>;
        return rawData['data'] as Map<String, dynamic>;
      }
      throw Exception('Failed to update module');
    });
  }
}
