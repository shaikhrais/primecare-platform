import 'package:primecare_models/primecare_models.dart';

class CfoAccountsReceivableModel extends BaseScreenState<CfoAccountsReceivableModel> {
  const CfoAccountsReceivableModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoAccountsReceivableModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoAccountsReceivableModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
