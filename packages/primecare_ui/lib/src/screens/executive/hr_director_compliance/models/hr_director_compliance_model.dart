import 'package:primecare_models/primecare_models.dart';

class HrDirectorComplianceModel extends BaseScreenState<HrDirectorComplianceModel> {
  const HrDirectorComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrDirectorComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrDirectorComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
