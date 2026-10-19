import 'package:primecare_models/primecare_models.dart';

class SocialWorkerAnalyticsModel extends BaseScreenState<SocialWorkerAnalyticsModel> {
  const SocialWorkerAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SocialWorkerAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SocialWorkerAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
