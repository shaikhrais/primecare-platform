import 'package:primecare_models/primecare_models.dart';

class PartnershipManagerAnalyticsModel extends BaseScreenState<PartnershipManagerAnalyticsModel> {
  const PartnershipManagerAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PartnershipManagerAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PartnershipManagerAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
