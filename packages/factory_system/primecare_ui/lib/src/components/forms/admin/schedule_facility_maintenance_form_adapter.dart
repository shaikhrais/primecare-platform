import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // TODO: Prisma API binding
    state = ScheduleFacilityMaintenanceFormViewModel(
      isLoading: true,
      data: state.data,
    );
    // Simulate fetch
    state = ScheduleFacilityMaintenanceFormViewModel(
      isLoading: false,
      data: {},
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
