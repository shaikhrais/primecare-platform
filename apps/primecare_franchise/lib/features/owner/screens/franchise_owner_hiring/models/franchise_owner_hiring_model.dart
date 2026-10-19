import 'package:primecare_models/primecare_models.dart';

class FranchiseOwnerHiringModel extends BaseScreenState<FranchiseOwnerHiringModel> {
  const FranchiseOwnerHiringModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseOwnerHiringModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerHiringModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
