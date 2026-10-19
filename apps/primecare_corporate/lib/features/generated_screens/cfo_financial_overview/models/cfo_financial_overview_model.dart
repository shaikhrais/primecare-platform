import 'package:primecare_models/primecare_models.dart';

class CfoFinancialOverviewModel extends BaseScreenState<CfoFinancialOverviewModel> {
  const CfoFinancialOverviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoFinancialOverviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoFinancialOverviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
