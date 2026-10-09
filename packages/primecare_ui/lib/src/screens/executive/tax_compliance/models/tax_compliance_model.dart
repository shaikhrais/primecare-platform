import 'package:primecare_models/primecare_models.dart';

class TaxComplianceModel extends BaseScreenState<TaxComplianceModel> {
  const TaxComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TaxComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TaxComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
