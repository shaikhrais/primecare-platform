import 'package:primecare_models/primecare_models.dart';

class StaffManagementModel extends BaseScreenState<StaffManagementModel> {
  const StaffManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  StaffManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => StaffManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
