import 'package:flutter_riverpod/flutter_riverpod.dart';
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
     // TODO: Prisma API binding
     state = ReviewCarePlanFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = ReviewCarePlanFormViewModel(isLoading: false, data: {});
  }
}

final reviewCarePlanFormAdapterProvider = NotifierProvider<ReviewCarePlanFormAdapter, ReviewCarePlanFormViewModel>(() {
  return ReviewCarePlanFormAdapter();
});
