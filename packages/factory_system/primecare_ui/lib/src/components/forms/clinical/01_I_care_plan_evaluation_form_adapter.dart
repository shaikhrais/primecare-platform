// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class CarePlanEvaluationFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
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
      final response = await client.get(
        '/api/v1/care-plan-evaluation-form-adapter',
      );
      state = CarePlanEvaluationFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = CarePlanEvaluationFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
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
