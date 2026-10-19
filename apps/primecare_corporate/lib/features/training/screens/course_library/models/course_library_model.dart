import 'package:primecare_models/primecare_models.dart';

class CourseLibraryModel extends BaseScreenState<CourseLibraryModel> {
  const CourseLibraryModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CourseLibraryModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CourseLibraryModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
