import 'package:primecare_models/primecare_models.dart';

class SystemVerificationAnalyticsModel extends BaseScreenState<SystemVerificationAnalyticsModel> {
  const SystemVerificationAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SystemVerificationAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SystemVerificationAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
