import 'package:primecare_models/primecare_models.dart';

class CfoTaxModel extends BaseScreenState<CfoTaxModel> {
  const CfoTaxModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoTaxModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoTaxModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
