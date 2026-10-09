import 'package:primecare_models/primecare_models.dart';

class BranchPerformanceModel extends BaseScreenState<BranchPerformanceModel> {
  const BranchPerformanceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BranchPerformanceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BranchPerformanceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
