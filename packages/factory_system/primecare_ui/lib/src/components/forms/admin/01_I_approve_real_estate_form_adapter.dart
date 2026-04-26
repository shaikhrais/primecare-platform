// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class ApproveRealEstateFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  ApproveRealEstateFormViewModel({this.isLoading = false, this.data});
}

class ApproveRealEstateFormAdapter
    extends Notifier<ApproveRealEstateFormViewModel> {
  @override
  ApproveRealEstateFormViewModel build() {
    return ApproveRealEstateFormViewModel();
  }

  Future<void> loadData() async {
    state = ApproveRealEstateFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/approve-real-estate-form-adapter',
      );
      state = ApproveRealEstateFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = ApproveRealEstateFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final approveRealEstateFormAdapterProvider =
    NotifierProvider<
      ApproveRealEstateFormAdapter,
      ApproveRealEstateFormViewModel
    >(() {
      return ApproveRealEstateFormAdapter();
    });
