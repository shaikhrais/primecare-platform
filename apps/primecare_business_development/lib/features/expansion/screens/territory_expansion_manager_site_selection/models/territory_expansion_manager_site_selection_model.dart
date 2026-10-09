import 'package:primecare_models/primecare_models.dart';

class TerritoryExpansionManagerSiteSelectionModel extends BaseScreenState<TerritoryExpansionManagerSiteSelectionModel> {
  const TerritoryExpansionManagerSiteSelectionModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritoryExpansionManagerSiteSelectionModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerSiteSelectionModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
