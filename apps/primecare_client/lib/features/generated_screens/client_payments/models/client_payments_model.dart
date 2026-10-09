import 'package:primecare_models/primecare_models.dart';

class ClientPaymentsModel extends BaseScreenState<ClientPaymentsModel> {
  const ClientPaymentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClientPaymentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClientPaymentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
