import 'package:primecare_models/primecare_models.dart';

class ClientIntakeModel extends BaseScreenState<ClientIntakeModel> {
  const ClientIntakeModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClientIntakeModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClientIntakeModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
