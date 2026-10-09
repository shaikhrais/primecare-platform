import 'package:primecare_models/primecare_models.dart';

class RpnVitalsModel extends BaseScreenState<RpnVitalsModel> {
  const RpnVitalsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RpnVitalsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RpnVitalsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
