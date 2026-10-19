import 'package:primecare_models/primecare_models.dart';

class CfoFranchiseFinancialsModel extends BaseScreenState<CfoFranchiseFinancialsModel> {
  const CfoFranchiseFinancialsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoFranchiseFinancialsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoFranchiseFinancialsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
