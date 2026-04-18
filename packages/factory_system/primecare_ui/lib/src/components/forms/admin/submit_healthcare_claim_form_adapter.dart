import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class SubmitHealthcareClaimFormViewModel {
  final bool isLoading;
  final dynamic data;
  SubmitHealthcareClaimFormViewModel({this.isLoading = false, this.data});
}

class SubmitHealthcareClaimFormAdapter
    extends Notifier<SubmitHealthcareClaimFormViewModel> {
  @override
  SubmitHealthcareClaimFormViewModel build() {
    return SubmitHealthcareClaimFormViewModel();
  }

  Future<void> loadData() async {
        state = dynamic(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/submit-healthcare-claim-form-adapter');
      state = dynamic(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = dynamic(isLoading: false, data: {});
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
