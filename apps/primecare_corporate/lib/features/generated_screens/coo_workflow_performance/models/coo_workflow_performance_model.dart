import 'package:primecare_models/primecare_models.dart';

class CooWorkflowPerformanceModel extends BaseScreenState<CooWorkflowPerformanceModel> {
  const CooWorkflowPerformanceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CooWorkflowPerformanceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CooWorkflowPerformanceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
