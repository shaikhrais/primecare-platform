import 'package:primecare_models/primecare_models.dart';

class RpnMedicationsModel extends BaseScreenState<RpnMedicationsModel> {
  const RpnMedicationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RpnMedicationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RpnMedicationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
