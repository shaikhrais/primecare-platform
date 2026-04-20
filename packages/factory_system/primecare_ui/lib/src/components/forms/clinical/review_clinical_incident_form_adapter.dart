import 'package:primecare_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Prisma Load Adapter

class ReviewClinicalIncidentFormViewModel {
  final bool isLoading;
  final dynamic data;
  ReviewClinicalIncidentFormViewModel({this.isLoading = false, this.data});
}

class ReviewClinicalIncidentFormAdapter
    extends Notifier<ReviewClinicalIncidentFormViewModel> {
  @override
  ReviewClinicalIncidentFormViewModel build() {
    return ReviewClinicalIncidentFormViewModel();
  }

  Future<void> loadData() async {
        state = ReviewClinicalIncidentFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/review-clinical-incident-form-adapter');
      state = ReviewClinicalIncidentFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = ReviewClinicalIncidentFormViewModel(isLoading: false, data: {});
    }
  }
}

final reviewClinicalIncidentFormAdapterProvider =
    NotifierProvider<
      ReviewClinicalIncidentFormAdapter,
      ReviewClinicalIncidentFormViewModel
    >(() {
      return ReviewClinicalIncidentFormAdapter();
    });
