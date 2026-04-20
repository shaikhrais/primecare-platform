import 'package:primecare_core/flutter_core.dart';

// Prisma Load Adapter

class ReviewCarePlanFormViewModel {
  final bool isLoading;
  final dynamic data;
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
      final response = await client.get('/api/v1/review-care-plan-form-adapter');
      state = ReviewCarePlanFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = ReviewCarePlanFormViewModel(isLoading: false, data: {});
    }
  }
}

final reviewCarePlanFormAdapterProvider =
    NotifierProvider<ReviewCarePlanFormAdapter, ReviewCarePlanFormViewModel>(
      () {
        return ReviewCarePlanFormAdapter();
      },
    );
