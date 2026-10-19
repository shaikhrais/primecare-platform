import 'package:primecare_models/primecare_models.dart';

class GrantFundingAllocationModel extends BaseScreenState<GrantFundingAllocationModel> {
  const GrantFundingAllocationModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GrantFundingAllocationModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GrantFundingAllocationModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
