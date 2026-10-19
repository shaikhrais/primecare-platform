import 'package:primecare_models/primecare_models.dart';

class InterviewSchedulingModel extends BaseScreenState<InterviewSchedulingModel> {
  const InterviewSchedulingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  InterviewSchedulingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => InterviewSchedulingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
