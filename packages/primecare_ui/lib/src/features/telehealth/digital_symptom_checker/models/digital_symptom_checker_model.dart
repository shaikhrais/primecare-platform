import 'package:primecare_models/primecare_models.dart';

class DigitalSymptomCheckerModel extends BaseScreenState<DigitalSymptomCheckerModel> {
  const DigitalSymptomCheckerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DigitalSymptomCheckerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DigitalSymptomCheckerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
