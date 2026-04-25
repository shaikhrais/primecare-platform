// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_course_architect_dashboard_screen.dart';

class CourseArchitectDashboardIntent extends AppScreenIntent {
  CourseArchitectDashboardIntent();

  @override
  String get name => 'course_architect_dashboard';

  @override
  String get route => '/offices/corporate/roles/course_architect/dashboard';

  @override
  String get title => 'Course Architect Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.courseArchitect;

  @override
  dynamic get provider => courseArchitectAdapterProvider;

  @override
  Widget build(BuildContext context) => const CourseArchitectDashboardScreen();
}
