import 'package:primecare_models/primecare_models.dart';

class CourseAssignmentModel extends BaseScreenState<CourseAssignmentModel> {
  const CourseAssignmentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CourseAssignmentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CourseAssignmentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
