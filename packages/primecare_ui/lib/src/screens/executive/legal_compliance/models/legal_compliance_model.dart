import 'package:primecare_models/primecare_models.dart';

class LegalComplianceModel extends BaseScreenState<LegalComplianceModel> {
  const LegalComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LegalComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LegalComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
