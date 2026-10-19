import 'package:primecare_models/primecare_models.dart';

class ExpenseManagementModel extends BaseScreenState<ExpenseManagementModel> {
  const ExpenseManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ExpenseManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ExpenseManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
