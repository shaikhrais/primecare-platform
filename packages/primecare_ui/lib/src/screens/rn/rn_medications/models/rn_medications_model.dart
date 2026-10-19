import 'package:primecare_models/primecare_models.dart';

class RnMedicationsModel extends BaseScreenState<RnMedicationsModel> {
  const RnMedicationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnMedicationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnMedicationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
