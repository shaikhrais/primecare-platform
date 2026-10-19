import 'package:primecare_models/primecare_models.dart';

class LocalMarketingManagerBudgetModel extends BaseScreenState<LocalMarketingManagerBudgetModel> {
  const LocalMarketingManagerBudgetModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LocalMarketingManagerBudgetModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerBudgetModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
