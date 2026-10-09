import 'package:primecare_models/primecare_models.dart';

class CtoReleaseManagementModel extends BaseScreenState<CtoReleaseManagementModel> {
  const CtoReleaseManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoReleaseManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoReleaseManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
