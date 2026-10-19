import 'package:primecare_models/primecare_models.dart';

class CisoComplianceModel extends BaseScreenState<CisoComplianceModel> {
  const CisoComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CisoComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CisoComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
