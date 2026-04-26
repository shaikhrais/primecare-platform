// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class ReviewClinicalIncidentFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  ReviewClinicalIncidentFormViewModel({this.isLoading = false, this.data});
}

class ReviewClinicalIncidentFormAdapter
    extends Notifier<ReviewClinicalIncidentFormViewModel> {
  @override
  ReviewClinicalIncidentFormViewModel build() {
    return ReviewClinicalIncidentFormViewModel();
  }

  Future<void> loadData() async {
    state = ReviewClinicalIncidentFormViewModel(
      isLoading: true,
      data: state.data,
    );
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/review-clinical-incident-form-adapter',
      );
      state = ReviewClinicalIncidentFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = ReviewClinicalIncidentFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
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
