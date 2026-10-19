import 'package:primecare_models/primecare_models.dart';

class CorrectiveActionModel extends BaseScreenState<CorrectiveActionModel> {
  const CorrectiveActionModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CorrectiveActionModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CorrectiveActionModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
