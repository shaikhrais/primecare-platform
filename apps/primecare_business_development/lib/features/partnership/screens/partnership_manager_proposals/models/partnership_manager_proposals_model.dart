import 'package:primecare_models/primecare_models.dart';

class PartnershipManagerProposalsModel extends BaseScreenState<PartnershipManagerProposalsModel> {
  const PartnershipManagerProposalsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PartnershipManagerProposalsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PartnershipManagerProposalsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
