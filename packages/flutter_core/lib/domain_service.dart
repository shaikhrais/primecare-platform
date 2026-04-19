import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/api_config.dart';
import 'network/api_client.dart';
import 'network/result.dart';
import 'api_providers.dart';
import 'telemetry_service.dart';
import 'src/models/domain_response.dart';

class DomainService {
  final Ref _ref;
  late final ApiClient _apiClient;
  late final ExecutionGateService _telemetry;

  DomainService(this._ref) {
    _apiClient = _ref.read(apiClientProvider);
    _telemetry = _ref.read(executionGateProvider);
  }

  // Intake Domain
  Future<Result<DomainResponse>> openCase(
    Map<String, dynamic> data,
  ) async {
    return Result.guardFuture<DomainResponse>(
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
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to open intake case',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'intakeCases'},
        );
        return DomainResponse.error(e.toString());
      },
    );
  }

  // Care Plans Domain
  Future<Result<DomainResponse>> updateCarePlan(
    Map<String, dynamic> data,
  ) async {
    return Result.guardFuture<DomainResponse>(
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
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to update care plan',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'carePlansUpdate'},
        );
        return DomainResponse.error(e.toString());
      },
    );
  }

  // Training Domain
  Future<Result<DomainResponse>> completeTrainingCourse(
    Map<String, dynamic> data,
  ) async {
    return Result.guardFuture<DomainResponse>(
      () async {
        final response = await _apiClient.post(
          ApiConfig.endpoints['trainingComplete']!,
          body: data,
        );
        _telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Training course completes successfully',
          metadata: {'endpoint': 'trainingComplete'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to complete training course',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'trainingComplete'},
        );
        return DomainResponse.error(e.toString());
      },
    );
  }

  // Support Domain
  Future<Result<DomainResponse>> escalateTicket(
    Map<String, dynamic> data,
  ) async {
    return Result.guardFuture<DomainResponse>(
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
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to escalate support ticket',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'supportEscalate'},
        );
        return DomainResponse.error(e.toString());
      },
    );
  }

  // Franchise Domain
  Future<Result<DomainResponse>> updateTerritory(
    Map<String, dynamic> data,
  ) async {
    return Result.guardFuture<DomainResponse>(
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
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to update territory',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'franchiseTerritoryUpdate'},
        );
        return DomainResponse.error(e.toString());
      },
    );
  }

  // Reporting Domain (Fetch)
  Future<Result<DomainResponse>> getReportingSummary() async {
    return Result.guardFuture<DomainResponse>(
      () async {
        final response = await _apiClient.get(
          ApiConfig.endpoints['reportingSummary']!,
        );
        _telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Reporting summary fetched successfully',
          metadata: {'endpoint': 'reportingSummary'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to fetch reporting summary',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'reportingSummary'},
        );
        return DomainResponse.error(e.toString());
      },
    );
  }

  // Admin Domain
  Future<Result<DomainResponse>> provisionStaff(
    Map<String, dynamic> data,
  ) async {
    return Result.guardFuture<DomainResponse>(
      () async {
        final response = await _apiClient.post(
          ApiConfig.endpoints['adminStaffProvision']!,
          body: data,
        );
        _telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Staff provisioned successfully',
          metadata: {'endpoint': 'adminStaffProvision'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to provision staff',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'adminStaffProvision'},
        );
        return DomainResponse.error(e.toString());
      },
    );
  }

  Future<Result<DomainResponse>> requestAuditOverride(
    Map<String, dynamic> data,
  ) async {
    return Result.guardFuture<DomainResponse>(
      () async {
        final response = await _apiClient.post(
          ApiConfig.endpoints['adminAuditOverride']!,
          body: data,
        );
        _telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Audit override requested successfully',
          metadata: {'endpoint': 'adminAuditOverride'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to request audit override',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'adminAuditOverride'},
        );
        return DomainResponse.error(e.toString());
      },
    );
  }
}

final domainServiceProvider = Provider((ref) => DomainService(ref));

