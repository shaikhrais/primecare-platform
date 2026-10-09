import 'package:primecare_models/primecare_models.dart';

class CtoComplianceModel extends BaseScreenState<CtoComplianceModel> {
  const CtoComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
