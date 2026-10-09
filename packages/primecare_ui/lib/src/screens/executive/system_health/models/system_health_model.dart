import 'package:primecare_models/primecare_models.dart';

class SystemHealthModel extends BaseScreenState<SystemHealthModel> {
  const SystemHealthModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SystemHealthModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SystemHealthModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
