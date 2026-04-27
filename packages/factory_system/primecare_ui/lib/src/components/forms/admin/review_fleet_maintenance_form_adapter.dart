// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

// Prisma Load Adapter

class ReviewFleetMaintenanceFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  ReviewFleetMaintenanceFormViewModel({this.isLoading = false, this.data});
}

class ReviewFleetMaintenanceFormAdapter
    extends Notifier<ReviewFleetMaintenanceFormViewModel> {
  @override
  ReviewFleetMaintenanceFormViewModel build() {
    return ReviewFleetMaintenanceFormViewModel();
  }

  Future<void> loadData() async {
    state = ReviewFleetMaintenanceFormViewModel(
      isLoading: true,
      data: state.data,
    );
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/review-fleet-maintenance-form-adapter',
      );
      state = ReviewFleetMaintenanceFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = ReviewFleetMaintenanceFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
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
