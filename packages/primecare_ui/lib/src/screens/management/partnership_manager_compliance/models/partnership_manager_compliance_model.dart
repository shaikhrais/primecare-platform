import 'package:primecare_models/primecare_models.dart';

class PartnershipManagerComplianceModel extends BaseScreenState<PartnershipManagerComplianceModel> {
  const PartnershipManagerComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PartnershipManagerComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PartnershipManagerComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
