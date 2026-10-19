import 'package:primecare_models/primecare_models.dart';

class RoleAccessModel extends BaseScreenState<RoleAccessModel> {
  const RoleAccessModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RoleAccessModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RoleAccessModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
