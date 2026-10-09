import 'package:primecare_models/primecare_models.dart';

class RegionalBdmTerritoryGrowthModel extends BaseScreenState<RegionalBdmTerritoryGrowthModel> {
  const RegionalBdmTerritoryGrowthModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmTerritoryGrowthModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmTerritoryGrowthModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
