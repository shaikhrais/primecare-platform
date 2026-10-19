import 'package:primecare_models/primecare_models.dart';

class AdminReconciliationModel extends BaseScreenState<AdminReconciliationModel> {
  const AdminReconciliationModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AdminReconciliationModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AdminReconciliationModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
