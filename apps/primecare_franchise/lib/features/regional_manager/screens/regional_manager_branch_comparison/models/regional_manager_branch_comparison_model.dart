import 'package:primecare_models/primecare_models.dart';

class RegionalManagerBranchComparisonModel extends BaseScreenState<RegionalManagerBranchComparisonModel> {
  const RegionalManagerBranchComparisonModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalManagerBranchComparisonModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalManagerBranchComparisonModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
