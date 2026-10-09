import 'package:primecare_models/primecare_models.dart';

class ScrumMasterComplianceModel extends BaseScreenState<ScrumMasterComplianceModel> {
  const ScrumMasterComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ScrumMasterComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ScrumMasterComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
