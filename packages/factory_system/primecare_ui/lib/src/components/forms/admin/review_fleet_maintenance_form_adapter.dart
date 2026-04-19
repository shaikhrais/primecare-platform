import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class ReviewFleetMaintenanceFormViewModel {
  final bool isLoading;
  final dynamic data;
  ReviewFleetMaintenanceFormViewModel({this.isLoading = false, this.data});
}

class ReviewFleetMaintenanceFormAdapter
    extends Notifier<ReviewFleetMaintenanceFormViewModel> {
  @override
  ReviewFleetMaintenanceFormViewModel build() {
    return ReviewFleetMaintenanceFormViewModel();
  }

  Future<void> loadData() async {
        state = ReviewFleetMaintenanceFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/review-fleet-maintenance-form-adapter');
      state = ReviewFleetMaintenanceFormViewModel(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = ReviewFleetMaintenanceFormViewModel(isLoading: false, data: {});
    }
  }
}

final reviewFleetMaintenanceFormAdapterProvider =
    NotifierProvider<
      ReviewFleetMaintenanceFormAdapter,
      ReviewFleetMaintenanceFormViewModel
    >(() {
      return ReviewFleetMaintenanceFormAdapter();
    });
