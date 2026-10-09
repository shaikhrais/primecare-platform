import 'package:primecare_models/primecare_models.dart';

class AdminRefundsModel extends BaseScreenState<AdminRefundsModel> {
  const AdminRefundsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AdminRefundsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AdminRefundsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
