import 'package:primecare_models/primecare_models.dart';

class PswMyClientsModel extends BaseScreenState<PswMyClientsModel> {
  const PswMyClientsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswMyClientsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswMyClientsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
