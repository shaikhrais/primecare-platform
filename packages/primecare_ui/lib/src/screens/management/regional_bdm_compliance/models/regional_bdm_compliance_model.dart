import 'package:primecare_models/primecare_models.dart';

class RegionalBdmComplianceModel extends BaseScreenState<RegionalBdmComplianceModel> {
  const RegionalBdmComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
