import 'package:primecare_models/primecare_models.dart';

class ClinicComplianceModel extends BaseScreenState<ClinicComplianceModel> {
  const ClinicComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
