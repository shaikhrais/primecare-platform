import 'package:primecare_models/primecare_models.dart';

class CeoStrategicKpisModel extends BaseScreenState<CeoStrategicKpisModel> {
  const CeoStrategicKpisModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CeoStrategicKpisModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CeoStrategicKpisModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
