import 'package:primecare_models/primecare_models.dart';

class TerritoryExpansionManagerReportsModel extends BaseScreenState<TerritoryExpansionManagerReportsModel> {
  const TerritoryExpansionManagerReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritoryExpansionManagerReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
