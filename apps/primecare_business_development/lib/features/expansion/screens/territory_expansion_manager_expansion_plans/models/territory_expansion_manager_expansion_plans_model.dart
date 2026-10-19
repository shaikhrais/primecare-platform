import 'package:primecare_models/primecare_models.dart';

class TerritoryExpansionManagerExpansionPlansModel extends BaseScreenState<TerritoryExpansionManagerExpansionPlansModel> {
  const TerritoryExpansionManagerExpansionPlansModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritoryExpansionManagerExpansionPlansModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerExpansionPlansModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
