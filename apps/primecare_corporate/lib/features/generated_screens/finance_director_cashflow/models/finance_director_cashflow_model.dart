import 'package:primecare_models/primecare_models.dart';

class FinanceDirectorCashflowModel extends BaseScreenState<FinanceDirectorCashflowModel> {
  const FinanceDirectorCashflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FinanceDirectorCashflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FinanceDirectorCashflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
