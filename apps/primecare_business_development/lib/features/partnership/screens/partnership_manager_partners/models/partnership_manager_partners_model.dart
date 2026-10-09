import 'package:primecare_models/primecare_models.dart';

class PartnershipManagerPartnersModel extends BaseScreenState<PartnershipManagerPartnersModel> {
  const PartnershipManagerPartnersModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PartnershipManagerPartnersModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PartnershipManagerPartnersModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
