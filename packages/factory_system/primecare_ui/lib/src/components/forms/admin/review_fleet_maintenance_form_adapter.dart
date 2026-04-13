import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class ReviewFleetMaintenanceFormViewModel {
  final bool isLoading;
  final dynamic data;
  ReviewFleetMaintenanceFormViewModel({this.isLoading = false, this.data});
}

class ReviewFleetMaintenanceFormAdapter extends Notifier<ReviewFleetMaintenanceFormViewModel> {
  @override
  ReviewFleetMaintenanceFormViewModel build() {
    return ReviewFleetMaintenanceFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = ReviewFleetMaintenanceFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = ReviewFleetMaintenanceFormViewModel(isLoading: false, data: {});
  }
}

final reviewFleetMaintenanceFormAdapterProvider = NotifierProvider<ReviewFleetMaintenanceFormAdapter, ReviewFleetMaintenanceFormViewModel>(() {
  return ReviewFleetMaintenanceFormAdapter();
});
