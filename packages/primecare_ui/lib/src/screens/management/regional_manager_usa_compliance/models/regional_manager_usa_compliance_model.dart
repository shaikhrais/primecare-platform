import 'package:primecare_models/primecare_models.dart';

class RegionalManagerUsaComplianceModel extends BaseScreenState<RegionalManagerUsaComplianceModel> {
  const RegionalManagerUsaComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalManagerUsaComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalManagerUsaComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
