import 'package:primecare_models/primecare_models.dart';

class PartnershipManagerActiveDealsModel extends BaseScreenState<PartnershipManagerActiveDealsModel> {
  const PartnershipManagerActiveDealsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PartnershipManagerActiveDealsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PartnershipManagerActiveDealsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
