// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

// Prisma Load Adapter

class SubmitHealthcareClaimFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  SubmitHealthcareClaimFormViewModel({this.isLoading = false, this.data});
}

class SubmitHealthcareClaimFormAdapter
    extends Notifier<SubmitHealthcareClaimFormViewModel> {
  @override
  SubmitHealthcareClaimFormViewModel build() {
    return SubmitHealthcareClaimFormViewModel();
  }

  Future<void> loadData() async {
    state = SubmitHealthcareClaimFormViewModel(
      isLoading: true,
      data: state.data,
    );
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/submit-healthcare-claim-form-adapter',
      );
      state = SubmitHealthcareClaimFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = SubmitHealthcareClaimFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final submitHealthcareClaimFormAdapterProvider =
    NotifierProvider<
      SubmitHealthcareClaimFormAdapter,
      SubmitHealthcareClaimFormViewModel
    >(() {
      return SubmitHealthcareClaimFormAdapter();
    });
