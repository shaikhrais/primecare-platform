import 'package:primecare_models/primecare_models.dart';

class LeadPipelineModel extends BaseScreenState<LeadPipelineModel> {
  const LeadPipelineModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LeadPipelineModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LeadPipelineModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
