import 'package:primecare_models/primecare_models.dart';

class FinanceDirectorAnalyticsModel extends BaseScreenState<FinanceDirectorAnalyticsModel> {
  const FinanceDirectorAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FinanceDirectorAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FinanceDirectorAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
