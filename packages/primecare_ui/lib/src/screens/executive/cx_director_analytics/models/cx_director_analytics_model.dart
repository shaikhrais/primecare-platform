import 'package:primecare_models/primecare_models.dart';

class CxDirectorAnalyticsModel extends BaseScreenState<CxDirectorAnalyticsModel> {
  const CxDirectorAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CxDirectorAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CxDirectorAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
