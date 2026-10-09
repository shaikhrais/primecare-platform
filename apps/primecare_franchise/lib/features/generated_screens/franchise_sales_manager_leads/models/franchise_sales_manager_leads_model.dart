import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesManagerLeadsModel extends BaseScreenState<FranchiseSalesManagerLeadsModel> {
  const FranchiseSalesManagerLeadsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesManagerLeadsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerLeadsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
