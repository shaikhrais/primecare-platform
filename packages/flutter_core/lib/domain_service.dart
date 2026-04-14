import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/api_config.dart';
import 'network/api_client.dart';
import 'network/result.dart';
import 'api_providers.dart';
import 'telemetry_service.dart';

class DomainService {
  final Ref _ref;
  late final ApiClient _apiClient;
  late final ExecutionGateService _telemetry;

  DomainService(this._ref) {
    _apiClient = _ref.read(apiClientProvider);
    _telemetry = _ref.read(executionGateProvider);
  }

  // Intake Domain
  Future<Result<Map<String, dynamic>>> openCase(Map<String, dynamic> data) async {
    return Result.guardFuture<Map<String, dynamic>>(
      () async {
        final response = await _apiClient.post(
          ApiConfig.endpoints['intakeCases']!,
          body: data,
        );
        _telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Intake case opened successfully',
          metadata: {'endpoint': 'intakeCases'},
        );
        return response.data;
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to open intake case',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'intakeCases'},
        );
        return <String, dynamic>{'error': e.toString(), 'fallback': true};
      },
    );
  }

  // Care Plans Domain
  Future<Result<Map<String, dynamic>>> updateCarePlan(Map<String, dynamic> data) async {
    return Result.guardFuture<Map<String, dynamic>>(
      () async {
        final response = await _apiClient.post(
          ApiConfig.endpoints['carePlansUpdate']!,
          body: data,
        );
        _telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Care plan updated successfully',
          metadata: {'endpoint': 'carePlansUpdate'},
        );
        return response.data;
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to update care plan',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'carePlansUpdate'},
        );
        return <String, dynamic>{'error': e.toString(), 'fallback': true};
      },
    );
  }

  // Training Domain
  Future<Result<Map<String, dynamic>>> completeTrainingCourse(
    Map<String, dynamic> data,
  ) async {
    return Result.guardFuture<Map<String, dynamic>>(
      () async {
        final response = await _apiClient.post(
          ApiConfig.endpoints['trainingComplete']!,
          body: data,
        );
        _telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Training course completing successfully',
          metadata: {'endpoint': 'trainingComplete'},
        );
        return response.data;
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to complete training course',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'trainingComplete'},
        );
        return <String, dynamic>{'error': e.toString(), 'fallback': true};
      },
    );
  }

  // Support Domain
  Future<Result<Map<String, dynamic>>> escalateTicket(Map<String, dynamic> data) async {
    return Result.guardFuture<Map<String, dynamic>>(
      () async {
        final response = await _apiClient.post(
          ApiConfig.endpoints['supportEscalate']!,
          body: data,
        );
        _telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Support ticket escalated successfully',
          metadata: {'endpoint': 'supportEscalate'},
        );
        return response.data;
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to escalate support ticket',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'supportEscalate'},
        );
        return <String, dynamic>{'error': e.toString(), 'fallback': true};
      },
    );
  }

  // Franchise Domain
  Future<Result<Map<String, dynamic>>> updateTerritory(
    Map<String, dynamic> data,
  ) async {
    return Result.guardFuture<Map<String, dynamic>>(
      () async {
        final response = await _apiClient.post(
          ApiConfig.endpoints['franchiseTerritoryUpdate']!,
          body: data,
        );
        _telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Territory updated successfully',
          metadata: {'endpoint': 'franchiseTerritoryUpdate'},
        );
        return response.data;
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to update territory',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'franchiseTerritoryUpdate'},
        );
        return <String, dynamic>{'error': e.toString(), 'fallback': true};
      },
    );
  }

  // Reporting Domain (Fetch)
  Future<Result<Map<String, dynamic>>> getReportingSummary() async {
    return Result.guardFuture<Map<String, dynamic>>(
      () async {
        final response = await _apiClient.get(
          ApiConfig.endpoints['reportingSummary']!,
        );
        _telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Reporting summary fetched successfully',
          metadata: {'endpoint': 'reportingSummary'},
        );
        return response.data;
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to fetch reporting summary',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'reportingSummary'},
        );
        return <String, dynamic>{'error': e.toString(), 'fallback': true};
      },
    );
  }
}
