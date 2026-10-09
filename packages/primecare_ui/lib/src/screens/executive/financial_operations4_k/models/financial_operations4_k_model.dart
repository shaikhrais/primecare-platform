import 'package:primecare_models/primecare_models.dart';

class FinancialOperations4KModel extends BaseScreenState<FinancialOperations4KModel> {
  const FinancialOperations4KModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FinancialOperations4KModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FinancialOperations4KModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
