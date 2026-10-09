import 'package:primecare_models/primecare_models.dart';

class AdminPaymentsModel extends BaseScreenState<AdminPaymentsModel> {
  const AdminPaymentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AdminPaymentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AdminPaymentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
