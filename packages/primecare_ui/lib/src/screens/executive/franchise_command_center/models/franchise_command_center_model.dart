import 'package:primecare_models/primecare_models.dart';

class FranchiseCommandCenterModel extends BaseScreenState<FranchiseCommandCenterModel> {
  const FranchiseCommandCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseCommandCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseCommandCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
