import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class ReviewVendorContractsFormViewModel {
  final bool isLoading;
  final dynamic data;
  ReviewVendorContractsFormViewModel({this.isLoading = false, this.data});
}

class ReviewVendorContractsFormAdapter extends Notifier<ReviewVendorContractsFormViewModel> {
  @override
  ReviewVendorContractsFormViewModel build() {
    return ReviewVendorContractsFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = ReviewVendorContractsFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = ReviewVendorContractsFormViewModel(isLoading: false, data: {});
  }
}

final reviewVendorContractsFormAdapterProvider = NotifierProvider<ReviewVendorContractsFormAdapter, ReviewVendorContractsFormViewModel>(() {
  return ReviewVendorContractsFormAdapter();
});
