import 'package:primecare_models/primecare_models.dart';
import '../network/base_api_transport.dart';
import '../network/base_transport_repository.dart';
import 'base_execution_gate_service.dart';
import 'base_business_workflow.dart';

abstract class BaseDomainServiceWorkflow<
  R extends BaseTransportRepository<BaseApiTransport>,
  T extends BaseExecutionGateService
>
    extends BaseBusinessWorkflow<R, T> {
  BaseDomainServiceWorkflow(super.repository, super.telemetry, super.endpoints);

  // Intake Domain
  Future<Result<DomainResponse>> openCase(Map<String, dynamic> data) async {
    return guard<DomainResponse>(
      () async {
        final response = await repository.post(
          endpoints['intakeCases']!,
          body: data,
        );
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Intake case opened successfully',
          metadata: {'endpoint': 'intakeCases'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        telemetry.failGate(
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
    return guard<DomainResponse>(
      () async {
        final response = await repository.post(
          endpoints['carePlansUpdate']!,
          body: data,
        );
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Care plan updated successfully',
          metadata: {'endpoint': 'carePlansUpdate'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        telemetry.failGate(
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
  Future<Result<DomainResponse>> getTrainingMetrics() async {
    return guard<DomainResponse>(
      () async {
        final response = await repository.get(
          endpoints['trainingDirectorView']!,
        );
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Training metrics fetched successfully',
          metadata: {'endpoint': 'trainingDirectorView'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to fetch training metrics',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'trainingDirectorView'},
        );
        return DomainResponse.error(e.toString());
      },
    );
  }

  Future<Result<DomainResponse>> completeTrainingCourse(
    Map<String, dynamic> data,
  ) async {
    return guard<DomainResponse>(
      () async {
        final response = await repository.post(
          endpoints['trainingComplete']!,
          body: data,
        );
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Training course completes successfully',
          metadata: {'endpoint': 'trainingComplete'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        telemetry.failGate(
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
    return guard<DomainResponse>(
      () async {
        final response = await repository.post(
          endpoints['supportEscalate']!,
          body: data,
        );
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Support ticket escalated successfully',
          metadata: {'endpoint': 'supportEscalate'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        telemetry.failGate(
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
    return guard<DomainResponse>(
      () async {
        final response = await repository.post(
          endpoints['franchiseTerritoryUpdate']!,
          body: data,
        );
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Territory updated successfully',
          metadata: {'endpoint': 'franchiseTerritoryUpdate'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        telemetry.failGate(
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
    return guard<DomainResponse>(
      () async {
        final response = await repository.get(endpoints['reportingSummary']!);
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Reporting summary fetched successfully',
          metadata: {'endpoint': 'reportingSummary'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        telemetry.failGate(
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
    return guard<DomainResponse>(
      () async {
        final response = await repository.post(
          endpoints['adminStaffProvision']!,
          body: data,
        );
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Staff provisioned successfully',
          metadata: {'endpoint': 'adminStaffProvision'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        telemetry.failGate(
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
    return guard<DomainResponse>(
      () async {
        final response = await repository.post(
          endpoints['adminAuditOverride']!,
          body: data,
        );
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Audit override requested successfully',
          metadata: {'endpoint': 'adminAuditOverride'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        telemetry.failGate(
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

  // Business Development Domain
  Future<Result<DomainResponse>> getPartnershipData() async {
    return guard<DomainResponse>(
      () async {
        final response = await repository.get(
          endpoints['officePartnershipLeadsView']!,
        );
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Partnership data fetched successfully',
          metadata: {'endpoint': 'officePartnershipLeadsView'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to fetch partnership data',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'officePartnershipLeadsView'},
        );
        return DomainResponse.error(e.toString());
      },
    );
  }

  Future<Result<DomainResponse>> getCoordinationMetrics() async {
    return guard<DomainResponse>(
      () async {
        final response = await repository.get(
          endpoints['trainingCoordinatorDashboard'] ??
              '/api/training-coordinator/dashboard',
        );
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Coordination metrics fetched successfully',
          metadata: {'endpoint': 'trainingCoordinatorDashboard'},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to fetch coordination metrics',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'trainingCoordinatorDashboard'},
        );
        return DomainResponse.error(e.toString());
      },
    );
  }

  Future<Result<DomainResponse>> getSupportMetrics() async {
    return getDomainMetrics('Support');
  }

  /// Generic metrics fetch for standard dashboard routes using the legacy DashboardService pattern.
  Future<Result<DomainResponse>> getDomainMetrics(String domain) async {
    return guard<DomainResponse>(
      () async {
        final response = await repository.get(
          '${endpoints['providerMetrics']}?route=$domain',
        );
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          '$domain metrics fetched successfully',
          metadata: {'endpoint': 'providerMetrics', 'route': domain},
        );
        return DomainResponse.fromJson(response.data as Map<String, dynamic>);
      },
      onError: (e, st) {
        telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to fetch $domain metrics',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'providerMetrics', 'route': domain},
        );
        return DomainResponse.error(e.toString());
      },
    );
  }
}
