import 'package:primecare_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Prisma Load Adapter

class ReviewMedicationInventoryFormViewModel {
  final bool isLoading;
  final dynamic data;
  ReviewMedicationInventoryFormViewModel({this.isLoading = false, this.data});
}

class ReviewMedicationInventoryFormAdapter
    extends Notifier<ReviewMedicationInventoryFormViewModel> {
  @override
  ReviewMedicationInventoryFormViewModel build() {
    return ReviewMedicationInventoryFormViewModel();
  }

  Future<void> loadData() async {
        state = ReviewMedicationInventoryFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/review-medication-inventory-form-adapter');
      state = ReviewMedicationInventoryFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = ReviewMedicationInventoryFormViewModel(isLoading: false, data: {});
    }
  }
}

final reviewMedicationInventoryFormAdapterProvider =
    NotifierProvider<
      ReviewMedicationInventoryFormAdapter,
      ReviewMedicationInventoryFormViewModel
    >(() {
      return ReviewMedicationInventoryFormAdapter();
    });
