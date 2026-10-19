import 'package:primecare_models/primecare_models.dart';

class PswCarePlanModel extends BaseScreenState<PswCarePlanModel> {
  const PswCarePlanModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswCarePlanModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswCarePlanModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
