import 'package:primecare_models/primecare_models.dart';

class CoordinatorHubModel extends BaseScreenState<CoordinatorHubModel> {
  const CoordinatorHubModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CoordinatorHubModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CoordinatorHubModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
