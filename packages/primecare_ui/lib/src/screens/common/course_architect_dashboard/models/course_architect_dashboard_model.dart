import 'package:primecare_models/primecare_models.dart';

class CourseArchitectDashboardModel extends BaseScreenState<CourseArchitectDashboardModel> {
  const CourseArchitectDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CourseArchitectDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CourseArchitectDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
