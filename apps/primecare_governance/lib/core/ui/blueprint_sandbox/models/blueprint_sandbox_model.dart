import 'package:primecare_models/primecare_models.dart';

class BlueprintSandboxModel extends BaseScreenState<BlueprintSandboxModel> {
  const BlueprintSandboxModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BlueprintSandboxModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BlueprintSandboxModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
