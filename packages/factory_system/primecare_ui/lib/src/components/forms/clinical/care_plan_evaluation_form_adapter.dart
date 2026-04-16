import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // TODO: Prisma API binding
    state = CarePlanEvaluationFormViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = CarePlanEvaluationFormViewModel(isLoading: false, data: {});
  }
}

final carePlanEvaluationFormAdapterProvider =
    NotifierProvider<
      CarePlanEvaluationFormAdapter,
      CarePlanEvaluationFormViewModel
    >(() {
      return CarePlanEvaluationFormAdapter();
    });
