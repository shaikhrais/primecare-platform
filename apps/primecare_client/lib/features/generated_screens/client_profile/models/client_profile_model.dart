import 'package:primecare_models/primecare_models.dart';

class ClientProfileModel extends BaseScreenState<ClientProfileModel> {
  const ClientProfileModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClientProfileModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClientProfileModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
