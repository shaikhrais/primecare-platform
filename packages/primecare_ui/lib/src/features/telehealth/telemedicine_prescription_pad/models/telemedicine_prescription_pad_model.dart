import 'package:primecare_models/primecare_models.dart';

class TelemedicinePrescriptionPadModel extends BaseScreenState<TelemedicinePrescriptionPadModel> {
  const TelemedicinePrescriptionPadModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TelemedicinePrescriptionPadModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TelemedicinePrescriptionPadModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
