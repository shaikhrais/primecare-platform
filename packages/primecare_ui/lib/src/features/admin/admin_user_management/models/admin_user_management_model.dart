import 'package:primecare_models/primecare_models.dart';

class AdminUserManagementModel extends BaseScreenState<AdminUserManagementModel> {
  const AdminUserManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AdminUserManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AdminUserManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
