import 'package:primecare_models/primecare_models.dart';

class CfoAccountsPayableModel extends BaseScreenState<CfoAccountsPayableModel> {
  const CfoAccountsPayableModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoAccountsPayableModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoAccountsPayableModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
