import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesManagerProposalsModel extends BaseScreenState<FranchiseSalesManagerProposalsModel> {
  const FranchiseSalesManagerProposalsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesManagerProposalsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerProposalsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
