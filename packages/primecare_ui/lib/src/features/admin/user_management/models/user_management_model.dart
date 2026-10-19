import 'package:primecare_models/primecare_models.dart';

class UserManagementModel extends BaseScreenState<UserManagementModel> {
  const UserManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  UserManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => UserManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
