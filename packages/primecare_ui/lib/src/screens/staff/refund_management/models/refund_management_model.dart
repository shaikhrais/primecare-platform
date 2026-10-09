import 'package:primecare_models/primecare_models.dart';

class RefundManagementModel extends BaseScreenState<RefundManagementModel> {
  const RefundManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RefundManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RefundManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
