import 'package:primecare_models/primecare_models.dart';

class CooBranchOperationsModel extends BaseScreenState<CooBranchOperationsModel> {
  const CooBranchOperationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CooBranchOperationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CooBranchOperationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
