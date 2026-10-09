import 'package:primecare_models/primecare_models.dart';

class CfoPayrollModel extends BaseScreenState<CfoPayrollModel> {
  const CfoPayrollModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoPayrollModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoPayrollModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
