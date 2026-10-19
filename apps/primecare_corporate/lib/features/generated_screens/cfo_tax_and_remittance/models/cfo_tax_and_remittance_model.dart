import 'package:primecare_models/primecare_models.dart';

class CfoTaxAndRemittanceModel extends BaseScreenState<CfoTaxAndRemittanceModel> {
  const CfoTaxAndRemittanceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoTaxAndRemittanceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoTaxAndRemittanceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
