import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class ReviewMedicationInventoryFormViewModel {
  final bool isLoading;
  final dynamic data;
  ReviewMedicationInventoryFormViewModel({this.isLoading = false, this.data});
}

class ReviewMedicationInventoryFormAdapter extends Notifier<ReviewMedicationInventoryFormViewModel> {
  @override
  ReviewMedicationInventoryFormViewModel build() {
    return ReviewMedicationInventoryFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = ReviewMedicationInventoryFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = ReviewMedicationInventoryFormViewModel(isLoading: false, data: {});
  }
}

final reviewMedicationInventoryFormAdapterProvider = NotifierProvider<ReviewMedicationInventoryFormAdapter, ReviewMedicationInventoryFormViewModel>(() {
  return ReviewMedicationInventoryFormAdapter();
});
