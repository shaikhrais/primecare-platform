import 'package:primecare_models/primecare_models.dart';

class CoordinatorSosModel extends BaseScreenState<CoordinatorSosModel> {
  const CoordinatorSosModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CoordinatorSosModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CoordinatorSosModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
