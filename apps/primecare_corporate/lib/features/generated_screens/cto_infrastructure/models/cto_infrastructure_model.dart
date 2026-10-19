import 'package:primecare_models/primecare_models.dart';

class CtoInfrastructureModel extends BaseScreenState<CtoInfrastructureModel> {
  const CtoInfrastructureModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoInfrastructureModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoInfrastructureModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
