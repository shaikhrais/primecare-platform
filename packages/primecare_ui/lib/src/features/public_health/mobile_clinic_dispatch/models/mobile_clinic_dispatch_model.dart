import 'package:primecare_models/primecare_models.dart';

class MobileClinicDispatchModel extends BaseScreenState<MobileClinicDispatchModel> {
  const MobileClinicDispatchModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MobileClinicDispatchModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MobileClinicDispatchModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
