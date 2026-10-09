import 'package:primecare_models/primecare_models.dart';

class CourseArchitectWorkflowModel extends BaseScreenState<CourseArchitectWorkflowModel> {
  const CourseArchitectWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CourseArchitectWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CourseArchitectWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
