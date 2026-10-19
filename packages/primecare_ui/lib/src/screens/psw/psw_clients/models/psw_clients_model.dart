import 'package:primecare_models/primecare_models.dart';

class PswClientsModel extends BaseScreenState<PswClientsModel> {
  const PswClientsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswClientsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswClientsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
