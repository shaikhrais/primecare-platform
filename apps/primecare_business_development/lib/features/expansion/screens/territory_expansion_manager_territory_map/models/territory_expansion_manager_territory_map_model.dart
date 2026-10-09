import 'package:primecare_models/primecare_models.dart';

class TerritoryExpansionManagerTerritoryMapModel extends BaseScreenState<TerritoryExpansionManagerTerritoryMapModel> {
  const TerritoryExpansionManagerTerritoryMapModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritoryExpansionManagerTerritoryMapModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerTerritoryMapModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
