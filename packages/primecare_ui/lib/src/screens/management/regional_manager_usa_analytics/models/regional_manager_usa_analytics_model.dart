import 'package:primecare_models/primecare_models.dart';

class RegionalManagerUsaAnalyticsModel extends BaseScreenState<RegionalManagerUsaAnalyticsModel> {
  const RegionalManagerUsaAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalManagerUsaAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalManagerUsaAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
