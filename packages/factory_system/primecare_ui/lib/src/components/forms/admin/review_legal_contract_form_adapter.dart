import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
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
        state = ReviewLegalContractFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/review-legal-contract-form-adapter');
      state = ReviewLegalContractFormViewModel(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = ReviewLegalContractFormViewModel(isLoading: false, data: {});
    }
  }
}

final reviewLegalContractFormAdapterProvider =
    NotifierProvider<
      ReviewLegalContractFormAdapter,
      ReviewLegalContractFormViewModel
    >(() {
      return ReviewLegalContractFormAdapter();
    });
