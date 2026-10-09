import 'package:primecare_models/primecare_models.dart';

class EmailMarketingAutomatorModel extends BaseScreenState<EmailMarketingAutomatorModel> {
  const EmailMarketingAutomatorModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  EmailMarketingAutomatorModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => EmailMarketingAutomatorModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
