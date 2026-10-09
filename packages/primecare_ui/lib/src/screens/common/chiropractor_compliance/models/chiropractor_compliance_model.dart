import 'package:primecare_models/primecare_models.dart';

class ChiropractorComplianceModel extends BaseScreenState<ChiropractorComplianceModel> {
  const ChiropractorComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropractorComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropractorComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
