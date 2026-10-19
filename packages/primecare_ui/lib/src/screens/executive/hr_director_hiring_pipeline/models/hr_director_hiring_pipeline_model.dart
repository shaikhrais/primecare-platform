import 'package:primecare_models/primecare_models.dart';

class HrDirectorHiringPipelineModel extends BaseScreenState<HrDirectorHiringPipelineModel> {
  const HrDirectorHiringPipelineModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrDirectorHiringPipelineModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrDirectorHiringPipelineModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
