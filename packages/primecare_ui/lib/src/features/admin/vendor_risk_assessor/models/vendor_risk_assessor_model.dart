import 'package:primecare_models/primecare_models.dart';

class VendorRiskAssessorModel extends BaseScreenState<VendorRiskAssessorModel> {
  const VendorRiskAssessorModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VendorRiskAssessorModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VendorRiskAssessorModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
