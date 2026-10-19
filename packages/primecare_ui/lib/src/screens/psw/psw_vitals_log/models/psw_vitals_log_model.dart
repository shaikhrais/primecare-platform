import 'package:primecare_models/primecare_models.dart';

class PswVitalsLogModel extends BaseScreenState<PswVitalsLogModel> {
  const PswVitalsLogModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswVitalsLogModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswVitalsLogModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
