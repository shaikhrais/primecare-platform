import 'package:primecare_models/primecare_models.dart';

class AdminInvoicesModel extends BaseScreenState<AdminInvoicesModel> {
  const AdminInvoicesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AdminInvoicesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AdminInvoicesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
