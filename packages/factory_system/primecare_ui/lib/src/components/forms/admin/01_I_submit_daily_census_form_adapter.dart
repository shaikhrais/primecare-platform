// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class SubmitDailyCensusFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  SubmitDailyCensusFormViewModel({this.isLoading = false, this.data});
}

class SubmitDailyCensusFormAdapter
    extends Notifier<SubmitDailyCensusFormViewModel> {
  @override
  SubmitDailyCensusFormViewModel build() {
    return SubmitDailyCensusFormViewModel();
  }

  Future<void> loadData() async {
    state = SubmitDailyCensusFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/submit-daily-census-form-adapter',
      );
      state = SubmitDailyCensusFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = SubmitDailyCensusFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final submitDailyCensusFormAdapterProvider =
    NotifierProvider<
      SubmitDailyCensusFormAdapter,
      SubmitDailyCensusFormViewModel
    >(() {
      return SubmitDailyCensusFormAdapter();
    });
