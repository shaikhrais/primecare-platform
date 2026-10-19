import 'package:primecare_models/primecare_models.dart';

class FranchiseOverviewModel extends BaseScreenState<FranchiseOverviewModel> {
  const FranchiseOverviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseOverviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseOverviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
