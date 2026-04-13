import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class ReviewClinicalIncidentFormViewModel {
  final bool isLoading;
  final dynamic data;
  ReviewClinicalIncidentFormViewModel({this.isLoading = false, this.data});
}

class ReviewClinicalIncidentFormAdapter extends Notifier<ReviewClinicalIncidentFormViewModel> {
  @override
  ReviewClinicalIncidentFormViewModel build() {
    return ReviewClinicalIncidentFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = ReviewClinicalIncidentFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = ReviewClinicalIncidentFormViewModel(isLoading: false, data: {});
  }
}

final reviewClinicalIncidentFormAdapterProvider = NotifierProvider<ReviewClinicalIncidentFormAdapter, ReviewClinicalIncidentFormViewModel>(() {
  return ReviewClinicalIncidentFormAdapter();
});
