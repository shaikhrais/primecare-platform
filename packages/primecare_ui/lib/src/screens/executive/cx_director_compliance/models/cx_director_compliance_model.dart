import 'package:primecare_models/primecare_models.dart';

class CxDirectorComplianceModel extends BaseScreenState<CxDirectorComplianceModel> {
  const CxDirectorComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CxDirectorComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CxDirectorComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
