import 'package:primecare_models/primecare_models.dart';

class CfoInvoicesModel extends BaseScreenState<CfoInvoicesModel> {
  const CfoInvoicesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoInvoicesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoInvoicesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
