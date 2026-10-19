import 'package:primecare_models/primecare_models.dart';

class CfoExpensesModel extends BaseScreenState<CfoExpensesModel> {
  const CfoExpensesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoExpensesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoExpensesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
