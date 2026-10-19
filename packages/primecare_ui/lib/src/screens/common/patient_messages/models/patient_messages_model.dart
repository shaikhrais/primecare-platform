import 'package:primecare_models/primecare_models.dart';

class PatientMessagesModel extends BaseScreenState<PatientMessagesModel> {
  const PatientMessagesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientMessagesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientMessagesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
