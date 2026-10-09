import 'package:primecare_models/primecare_models.dart';

class RegionalBdmAnalyticsModel extends BaseScreenState<RegionalBdmAnalyticsModel> {
  const RegionalBdmAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
