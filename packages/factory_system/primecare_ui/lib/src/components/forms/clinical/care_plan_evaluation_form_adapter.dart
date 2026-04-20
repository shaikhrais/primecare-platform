import 'package:primecare_core/flutter_core.dart';

// Prisma Load Adapter

class CarePlanEvaluationFormViewModel {
  final bool isLoading;
  final dynamic data;
  CarePlanEvaluationFormViewModel({this.isLoading = false, this.data});
}

class CarePlanEvaluationFormAdapter
    extends Notifier<CarePlanEvaluationFormViewModel> {
  @override
  CarePlanEvaluationFormViewModel build() {
    return CarePlanEvaluationFormViewModel();
  }

  Future<void> loadData() async {
        state = CarePlanEvaluationFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/care-plan-evaluation-form-adapter');
      state = CarePlanEvaluationFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = CarePlanEvaluationFormViewModel(isLoading: false, data: {});
    }
  }
}

final carePlanEvaluationFormAdapterProvider =
    NotifierProvider<
      CarePlanEvaluationFormAdapter,
      CarePlanEvaluationFormViewModel
    >(() {
      return CarePlanEvaluationFormAdapter();
    });
