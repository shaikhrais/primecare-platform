import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesManagerSalesPipelineModel extends BaseScreenState<FranchiseSalesManagerSalesPipelineModel> {
  const FranchiseSalesManagerSalesPipelineModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesManagerSalesPipelineModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerSalesPipelineModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
