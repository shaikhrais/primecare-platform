import 'package:primecare_models/primecare_models.dart';

class TerritoryExpansionManagerAnalyticsModel extends BaseScreenState<TerritoryExpansionManagerAnalyticsModel> {
  const TerritoryExpansionManagerAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritoryExpansionManagerAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
