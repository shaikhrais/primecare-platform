import 'package:primecare_models/primecare_models.dart';

class CisoAnalyticsModel extends BaseScreenState<CisoAnalyticsModel> {
  const CisoAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CisoAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CisoAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
