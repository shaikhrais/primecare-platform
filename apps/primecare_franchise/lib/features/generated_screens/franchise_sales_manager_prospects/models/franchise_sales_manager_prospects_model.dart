import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesManagerProspectsModel extends BaseScreenState<FranchiseSalesManagerProspectsModel> {
  const FranchiseSalesManagerProspectsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesManagerProspectsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerProspectsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
