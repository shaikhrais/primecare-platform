import 'package:primecare_models/primecare_models.dart';

class FranchiseOwnerClientsModel extends BaseScreenState<FranchiseOwnerClientsModel> {
  const FranchiseOwnerClientsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseOwnerClientsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerClientsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
