import 'package:primecare_models/primecare_models.dart';

class LpnAnalyticsModel extends BaseScreenState<LpnAnalyticsModel> {
  const LpnAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LpnAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LpnAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
