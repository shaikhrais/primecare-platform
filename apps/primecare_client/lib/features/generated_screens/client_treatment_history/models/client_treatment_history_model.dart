import 'package:primecare_models/primecare_models.dart';

class ClientTreatmentHistoryModel extends BaseScreenState<ClientTreatmentHistoryModel> {
  const ClientTreatmentHistoryModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClientTreatmentHistoryModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClientTreatmentHistoryModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
