import 'package:primecare_models/primecare_models.dart';

class SubstanceAbusePreventionTrackerModel extends BaseScreenState<SubstanceAbusePreventionTrackerModel> {
  const SubstanceAbusePreventionTrackerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SubstanceAbusePreventionTrackerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SubstanceAbusePreventionTrackerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
