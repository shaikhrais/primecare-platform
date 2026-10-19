import 'package:primecare_models/primecare_models.dart';

class CtoVerificationHubModel extends BaseScreenState<CtoVerificationHubModel> {
  const CtoVerificationHubModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoVerificationHubModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoVerificationHubModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
