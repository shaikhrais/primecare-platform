import 'package:primecare_models/primecare_models.dart';

class FranchiseOwnerBranchOverviewModel extends BaseScreenState<FranchiseOwnerBranchOverviewModel> {
  const FranchiseOwnerBranchOverviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseOwnerBranchOverviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerBranchOverviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
