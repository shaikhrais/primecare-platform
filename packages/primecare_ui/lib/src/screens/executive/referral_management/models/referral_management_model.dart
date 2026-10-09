import 'package:primecare_models/primecare_models.dart';

class ReferralManagementModel extends BaseScreenState<ReferralManagementModel> {
  const ReferralManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ReferralManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ReferralManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
