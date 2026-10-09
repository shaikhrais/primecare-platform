import 'package:primecare_models/primecare_models.dart';

class RoleAccessMatrixModel extends BaseScreenState<RoleAccessMatrixModel> {
  const RoleAccessMatrixModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RoleAccessMatrixModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RoleAccessMatrixModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
