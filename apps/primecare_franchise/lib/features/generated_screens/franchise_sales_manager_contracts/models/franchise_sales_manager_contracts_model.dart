import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesManagerContractsModel extends BaseScreenState<FranchiseSalesManagerContractsModel> {
  const FranchiseSalesManagerContractsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesManagerContractsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerContractsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
