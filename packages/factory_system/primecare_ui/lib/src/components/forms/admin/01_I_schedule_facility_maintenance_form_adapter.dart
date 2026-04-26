// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

// Prisma Load Adapter

class ScheduleFacilityMaintenanceFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  ScheduleFacilityMaintenanceFormViewModel({this.isLoading = false, this.data});
}

class ScheduleFacilityMaintenanceFormAdapter
    extends Notifier<ScheduleFacilityMaintenanceFormViewModel> {
  @override
  ScheduleFacilityMaintenanceFormViewModel build() {
    return ScheduleFacilityMaintenanceFormViewModel();
  }

  Future<void> loadData() async {
    state = ScheduleFacilityMaintenanceFormViewModel(
      isLoading: true,
      data: state.data,
    );

    final telemetry = ref.read(executionGateProvider);
    final apiClient = ref.read(apiClientProvider);

    telemetry.passGate(
      ExecutionGateCategory.domainApi,
      'Starting Facility Maintenance fetch',
    );

    final result = await Result.guardFuture<dynamic>(() async {
      final response = await apiClient.get(
        '/api/v1/admin/facility/maintenance',
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      return false;
    });

    result.fold(
      (data) {
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Facility Maintenance API fetched successfully',
        );
        state = ScheduleFacilityMaintenanceFormViewModel(
          isLoading: false,
          data: (data is bool && !data) ? null : data as Map<String, dynamic>?,
        );
      },
      (error) {
        telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Facility Maintenance API failed',
          error: error,
        );
        state = ScheduleFacilityMaintenanceFormViewModel(
          isLoading: false,
          data: <String, dynamic>{},
        );
      },
    );
  }
}

final scheduleFacilityMaintenanceFormAdapterProvider =
    NotifierProvider<
      ScheduleFacilityMaintenanceFormAdapter,
      ScheduleFacilityMaintenanceFormViewModel
    >(() {
      return ScheduleFacilityMaintenanceFormAdapter();
    });
