import 'package:primecare_models/primecare_models.dart';

class CourseArchitectModel extends BaseScreenState<CourseArchitectModel> {
  const CourseArchitectModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CourseArchitectModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CourseArchitectModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
