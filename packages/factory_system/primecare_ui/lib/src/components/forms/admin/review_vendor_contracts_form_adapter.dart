import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class ReviewVendorContractsFormViewModel {
  final bool isLoading;
  final dynamic data;
  ReviewVendorContractsFormViewModel({this.isLoading = false, this.data});
}

class ReviewVendorContractsFormAdapter
    extends Notifier<ReviewVendorContractsFormViewModel> {
  @override
  ReviewVendorContractsFormViewModel build() {
    return ReviewVendorContractsFormViewModel();
  }

  Future<void> loadData() async {
        state = ReviewVendorContractsFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/review-vendor-contracts-form-adapter');
      state = ReviewVendorContractsFormViewModel(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = ReviewVendorContractsFormViewModel(isLoading: false, data: {});
    }
  }
}

final reviewVendorContractsFormAdapterProvider =
    NotifierProvider<
      ReviewVendorContractsFormAdapter,
      ReviewVendorContractsFormViewModel
    >(() {
      return ReviewVendorContractsFormAdapter();
    });
