import 'package:primecare_models/primecare_models.dart';

class ReceptionistCallsModel extends BaseScreenState<ReceptionistCallsModel> {
  const ReceptionistCallsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ReceptionistCallsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ReceptionistCallsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
