import 'package:primecare_models/primecare_models.dart';

class ClientProgressModel extends BaseScreenState<ClientProgressModel> {
  const ClientProgressModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClientProgressModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClientProgressModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
