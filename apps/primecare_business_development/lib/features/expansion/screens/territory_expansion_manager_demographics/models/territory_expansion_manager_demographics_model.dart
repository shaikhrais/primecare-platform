import 'package:primecare_models/primecare_models.dart';

class TerritoryExpansionManagerDemographicsModel extends BaseScreenState<TerritoryExpansionManagerDemographicsModel> {
  const TerritoryExpansionManagerDemographicsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritoryExpansionManagerDemographicsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerDemographicsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
