import 'package:primecare_models/primecare_models.dart';

class SupportComplianceModel extends BaseScreenState<SupportComplianceModel> {
  const SupportComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SupportComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SupportComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
