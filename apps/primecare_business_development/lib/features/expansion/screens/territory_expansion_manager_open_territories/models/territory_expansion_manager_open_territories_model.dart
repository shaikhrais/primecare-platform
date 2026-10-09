import 'package:primecare_models/primecare_models.dart';

class TerritoryExpansionManagerOpenTerritoriesModel extends BaseScreenState<TerritoryExpansionManagerOpenTerritoriesModel> {
  const TerritoryExpansionManagerOpenTerritoriesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritoryExpansionManagerOpenTerritoriesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerOpenTerritoriesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
