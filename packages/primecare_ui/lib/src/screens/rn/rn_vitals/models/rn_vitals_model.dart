import 'package:primecare_models/primecare_models.dart';

class RnVitalsModel extends BaseScreenState<RnVitalsModel> {
  const RnVitalsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnVitalsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnVitalsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
