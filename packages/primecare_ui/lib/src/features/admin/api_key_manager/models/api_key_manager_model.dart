import 'package:primecare_models/primecare_models.dart';

class ApiKeyManagerModel extends BaseScreenState<ApiKeyManagerModel> {
  const ApiKeyManagerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ApiKeyManagerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ApiKeyManagerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
