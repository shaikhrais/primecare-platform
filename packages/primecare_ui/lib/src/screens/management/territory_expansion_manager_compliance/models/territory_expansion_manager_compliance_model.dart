import 'package:primecare_models/primecare_models.dart';

class TerritoryExpansionManagerComplianceModel extends BaseScreenState<TerritoryExpansionManagerComplianceModel> {
  const TerritoryExpansionManagerComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritoryExpansionManagerComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
