import 'package:primecare_models/primecare_models.dart';

class ChiropractorWorkflowModel extends BaseScreenState<ChiropractorWorkflowModel> {
  const ChiropractorWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropractorWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropractorWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
