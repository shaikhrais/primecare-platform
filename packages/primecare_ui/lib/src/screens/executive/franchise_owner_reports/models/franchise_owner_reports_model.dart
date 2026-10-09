import 'package:primecare_models/primecare_models.dart';

class FranchiseOwnerReportsModel extends BaseScreenState<FranchiseOwnerReportsModel> {
  const FranchiseOwnerReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseOwnerReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
