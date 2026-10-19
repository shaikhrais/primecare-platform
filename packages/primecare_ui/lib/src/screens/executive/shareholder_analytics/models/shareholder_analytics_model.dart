import 'package:primecare_models/primecare_models.dart';

class ShareholderAnalyticsModel extends BaseScreenState<ShareholderAnalyticsModel> {
  const ShareholderAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ShareholderAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ShareholderAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
