import 'package:primecare_models/primecare_models.dart';

class FranchiseOwnerComplianceModel extends BaseScreenState<FranchiseOwnerComplianceModel> {
  const FranchiseOwnerComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseOwnerComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
