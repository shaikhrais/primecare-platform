import 'package:primecare_models/primecare_models.dart';

class FranchiseLeadModel extends BaseScreenState<FranchiseLeadModel> {
  const FranchiseLeadModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseLeadModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseLeadModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
