import 'package:primecare_models/primecare_models.dart';

class CaregiverClientProfileModel extends BaseScreenState<CaregiverClientProfileModel> {
  const CaregiverClientProfileModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CaregiverClientProfileModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CaregiverClientProfileModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
