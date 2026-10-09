import 'package:primecare_models/primecare_models.dart';

class ReferralNetworkManagerModel extends BaseScreenState<ReferralNetworkManagerModel> {
  const ReferralNetworkManagerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ReferralNetworkManagerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ReferralNetworkManagerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
