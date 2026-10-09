import 'package:primecare_models/primecare_models.dart';

class VipManagerAnalyticsModel extends BaseScreenState<VipManagerAnalyticsModel> {
  const VipManagerAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VipManagerAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VipManagerAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
