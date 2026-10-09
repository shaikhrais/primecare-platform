import 'package:primecare_models/primecare_models.dart';

class HiringPipelineModel extends BaseScreenState<HiringPipelineModel> {
  const HiringPipelineModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HiringPipelineModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HiringPipelineModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
