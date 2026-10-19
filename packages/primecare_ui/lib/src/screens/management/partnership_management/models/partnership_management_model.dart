import 'package:primecare_models/primecare_models.dart';

class PartnershipManagementModel extends BaseScreenState<PartnershipManagementModel> {
  const PartnershipManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PartnershipManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PartnershipManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
