import 'package:primecare_models/primecare_models.dart';

class ConsentManagementConsoleModel extends BaseScreenState<ConsentManagementConsoleModel> {
  const ConsentManagementConsoleModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ConsentManagementConsoleModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ConsentManagementConsoleModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
