import 'package:primecare_models/primecare_models.dart';

class PartnershipManagerRenewalsModel extends BaseScreenState<PartnershipManagerRenewalsModel> {
  const PartnershipManagerRenewalsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PartnershipManagerRenewalsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PartnershipManagerRenewalsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
