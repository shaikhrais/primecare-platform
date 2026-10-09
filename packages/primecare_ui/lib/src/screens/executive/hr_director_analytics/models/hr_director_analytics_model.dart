import 'package:primecare_models/primecare_models.dart';

class HrDirectorAnalyticsModel extends BaseScreenState<HrDirectorAnalyticsModel> {
  const HrDirectorAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrDirectorAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrDirectorAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
