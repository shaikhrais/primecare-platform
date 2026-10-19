import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesManagerComplianceModel extends BaseScreenState<FranchiseSalesManagerComplianceModel> {
  const FranchiseSalesManagerComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesManagerComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
