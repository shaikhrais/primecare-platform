import 'package:primecare_models/primecare_models.dart';

class CnsAnalyticsModel extends BaseScreenState<CnsAnalyticsModel> {
  const CnsAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CnsAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CnsAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
