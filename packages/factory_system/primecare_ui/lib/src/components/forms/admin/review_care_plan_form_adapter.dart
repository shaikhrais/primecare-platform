// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

// Prisma Load Adapter

class ReviewCarePlanFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  ReviewCarePlanFormViewModel({this.isLoading = false, this.data});
}

class ReviewCarePlanFormAdapter extends Notifier<ReviewCarePlanFormViewModel> {
  @override
  ReviewCarePlanFormViewModel build() {
    return ReviewCarePlanFormViewModel();
  }

  Future<void> loadData() async {
    state = ReviewCarePlanFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/review-care-plan-form-adapter',
      );
      state = ReviewCarePlanFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = ReviewCarePlanFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final reviewCarePlanFormAdapterProvider =
    NotifierProvider<ReviewCarePlanFormAdapter, ReviewCarePlanFormViewModel>(
      () {
        return ReviewCarePlanFormAdapter();
      },
    );
