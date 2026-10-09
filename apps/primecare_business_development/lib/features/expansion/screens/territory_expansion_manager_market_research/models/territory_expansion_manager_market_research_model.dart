import 'package:primecare_models/primecare_models.dart';

class TerritoryExpansionManagerMarketResearchModel extends BaseScreenState<TerritoryExpansionManagerMarketResearchModel> {
  const TerritoryExpansionManagerMarketResearchModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritoryExpansionManagerMarketResearchModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerMarketResearchModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
