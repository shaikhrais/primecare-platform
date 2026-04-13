import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class ApproveRealEstateFormViewModel {
  final bool isLoading;
  final dynamic data;
  ApproveRealEstateFormViewModel({this.isLoading = false, this.data});
}

class ApproveRealEstateFormAdapter extends Notifier<ApproveRealEstateFormViewModel> {
  @override
  ApproveRealEstateFormViewModel build() {
    return ApproveRealEstateFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = ApproveRealEstateFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = ApproveRealEstateFormViewModel(isLoading: false, data: {});
  }
}

final approveRealEstateFormAdapterProvider = NotifierProvider<ApproveRealEstateFormAdapter, ApproveRealEstateFormViewModel>(() {
  return ApproveRealEstateFormAdapter();
});
