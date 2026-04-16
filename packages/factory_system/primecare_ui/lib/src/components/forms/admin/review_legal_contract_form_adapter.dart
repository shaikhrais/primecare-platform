import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class ReviewLegalContractFormViewModel {
  final bool isLoading;
  final dynamic data;
  ReviewLegalContractFormViewModel({this.isLoading = false, this.data});
}

class ReviewLegalContractFormAdapter
    extends Notifier<ReviewLegalContractFormViewModel> {
  @override
  ReviewLegalContractFormViewModel build() {
    return ReviewLegalContractFormViewModel();
  }

  Future<void> loadData() async {
    // TODO: Prisma API binding
    state = ReviewLegalContractFormViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = ReviewLegalContractFormViewModel(isLoading: false, data: {});
  }
}

final reviewLegalContractFormAdapterProvider =
    NotifierProvider<
      ReviewLegalContractFormAdapter,
      ReviewLegalContractFormViewModel
    >(() {
      return ReviewLegalContractFormAdapter();
    });
