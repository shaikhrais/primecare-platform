import 'package:primecare_models/primecare_models.dart';

class AssessmentsModel extends BaseScreenState<AssessmentsModel> {
  const AssessmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AssessmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AssessmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
