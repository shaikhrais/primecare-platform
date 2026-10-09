import 'package:primecare_models/primecare_models.dart';

class SecurityHubModel extends BaseScreenState<SecurityHubModel> {
  const SecurityHubModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SecurityHubModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SecurityHubModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
