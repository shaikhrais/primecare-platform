import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class ScheduleFacilityMaintenanceFormViewModel {
  final bool isLoading;
  final dynamic data;
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

    telemetry.passGate(ExecutionGateCategory.domainApi, 'Starting Facility Maintenance fetch');

    final result = await Result.guardFuture<dynamic>(() async {
      final response = await apiClient.get('/api/v1/admin/facility/maintenance');
      if (response.statusCode == 200) {
        return response.data;
      }
        return false;
    });

    result.fold(
      (data) {
        telemetry.passGate(ExecutionGateCategory.domainApi, 'Facility Maintenance API fetched successfully');
        state = ScheduleFacilityMaintenanceFormViewModel(
          isLoading: false,
          data: data,
        );
      },
      (error) {
        telemetry.failGate(ExecutionGateCategory.domainApi, 'Facility Maintenance API failed', error: error);
        state = ScheduleFacilityMaintenanceFormViewModel(
          isLoading: false,
          data: {},
        );
      }
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
