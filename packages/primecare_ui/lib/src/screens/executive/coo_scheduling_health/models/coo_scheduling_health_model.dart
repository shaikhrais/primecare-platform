import 'package:primecare_models/primecare_models.dart';

class CooSchedulingHealthModel extends BaseScreenState<CooSchedulingHealthModel> {
  const CooSchedulingHealthModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CooSchedulingHealthModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CooSchedulingHealthModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
