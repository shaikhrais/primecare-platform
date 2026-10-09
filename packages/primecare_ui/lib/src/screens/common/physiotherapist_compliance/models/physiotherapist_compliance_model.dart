import 'package:primecare_models/primecare_models.dart';

class PhysiotherapistComplianceModel extends BaseScreenState<PhysiotherapistComplianceModel> {
  const PhysiotherapistComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysiotherapistComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysiotherapistComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
