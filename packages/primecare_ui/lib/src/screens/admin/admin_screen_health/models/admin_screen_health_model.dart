import 'package:primecare_models/primecare_models.dart';

class AdminScreenHealthModel extends BaseScreenState<AdminScreenHealthModel> {
  const AdminScreenHealthModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AdminScreenHealthModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AdminScreenHealthModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
