import 'package:primecare_models/primecare_models.dart';

class AgentDispatchModel extends BaseScreenState<AgentDispatchModel> {
  const AgentDispatchModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AgentDispatchModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AgentDispatchModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
