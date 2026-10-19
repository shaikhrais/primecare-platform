import 'package:primecare_models/primecare_models.dart';

class CooBranchComparisonModel extends BaseScreenState<CooBranchComparisonModel> {
  const CooBranchComparisonModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CooBranchComparisonModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CooBranchComparisonModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
