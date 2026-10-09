import 'package:primecare_models/primecare_models.dart';

class AdminReportsModel extends BaseScreenState<AdminReportsModel> {
  const AdminReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AdminReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AdminReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
