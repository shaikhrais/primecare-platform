import 'package:primecare_models/primecare_models.dart';

class ReleaseManagementModel extends BaseScreenState<ReleaseManagementModel> {
  const ReleaseManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ReleaseManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ReleaseManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
