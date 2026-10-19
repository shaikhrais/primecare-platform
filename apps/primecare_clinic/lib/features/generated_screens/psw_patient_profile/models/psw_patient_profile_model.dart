import 'package:primecare_models/primecare_models.dart';

class PswPatientProfileModel extends BaseScreenState<PswPatientProfileModel> {
  const PswPatientProfileModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswPatientProfileModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswPatientProfileModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
