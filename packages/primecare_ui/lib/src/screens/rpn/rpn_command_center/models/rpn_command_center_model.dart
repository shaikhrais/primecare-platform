import 'package:primecare_models/primecare_models.dart';

class RpnCommandCenterModel extends BaseScreenState<RpnCommandCenterModel> {
  const RpnCommandCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RpnCommandCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RpnCommandCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
