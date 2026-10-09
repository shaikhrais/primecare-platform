import 'package:primecare_models/primecare_models.dart';

class PortalComplianceModel extends BaseScreenState<PortalComplianceModel> {
  const PortalComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PortalComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PortalComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
