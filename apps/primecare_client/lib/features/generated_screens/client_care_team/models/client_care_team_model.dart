import 'package:primecare_models/primecare_models.dart';

class ClientCareTeamModel extends BaseScreenState<ClientCareTeamModel> {
  const ClientCareTeamModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClientCareTeamModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClientCareTeamModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
