import 'package:primecare_models/primecare_models.dart';

class RegionalBdmFranchisePipelineModel extends BaseScreenState<RegionalBdmFranchisePipelineModel> {
  const RegionalBdmFranchisePipelineModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmFranchisePipelineModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmFranchisePipelineModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
