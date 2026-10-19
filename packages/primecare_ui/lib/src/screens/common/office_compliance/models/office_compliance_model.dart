import 'package:primecare_models/primecare_models.dart';

class OfficeComplianceModel extends BaseScreenState<OfficeComplianceModel> {
  const OfficeComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OfficeComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OfficeComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
