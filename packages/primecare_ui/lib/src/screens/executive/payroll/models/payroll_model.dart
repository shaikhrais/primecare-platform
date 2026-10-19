import 'package:primecare_models/primecare_models.dart';

class PayrollModel extends BaseScreenState<PayrollModel> {
  const PayrollModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PayrollModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PayrollModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
