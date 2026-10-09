import 'package:primecare_models/primecare_models.dart';

class SupplyChainCostAnalyzerModel extends BaseScreenState<SupplyChainCostAnalyzerModel> {
  const SupplyChainCostAnalyzerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SupplyChainCostAnalyzerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SupplyChainCostAnalyzerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
