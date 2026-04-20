import 'package:primecare_core/flutter_core.dart';

// Prisma Load Adapter

class SubmitDailyCensusFormViewModel {
  final bool isLoading;
  final dynamic data;
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
      final response = await client.get('/api/v1/submit-daily-census-form-adapter');
      state = SubmitDailyCensusFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = SubmitDailyCensusFormViewModel(isLoading: false, data: {});
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
