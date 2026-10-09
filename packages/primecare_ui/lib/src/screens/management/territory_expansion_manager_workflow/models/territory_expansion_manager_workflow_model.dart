import 'package:primecare_models/primecare_models.dart';

class TerritoryExpansionManagerWorkflowModel extends BaseScreenState<TerritoryExpansionManagerWorkflowModel> {
  const TerritoryExpansionManagerWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritoryExpansionManagerWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
