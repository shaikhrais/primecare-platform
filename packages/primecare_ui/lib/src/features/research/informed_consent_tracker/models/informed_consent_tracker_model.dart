import 'package:primecare_models/primecare_models.dart';

class InformedConsentTrackerModel extends BaseScreenState<InformedConsentTrackerModel> {
  const InformedConsentTrackerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  InformedConsentTrackerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => InformedConsentTrackerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
