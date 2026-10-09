import 'package:primecare_models/primecare_models.dart';

class CoordinatorDispatchMapModel extends BaseScreenState<CoordinatorDispatchMapModel> {
  const CoordinatorDispatchMapModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CoordinatorDispatchMapModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CoordinatorDispatchMapModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
