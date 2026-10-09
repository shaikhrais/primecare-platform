import 'package:primecare_models/primecare_models.dart';

class SchoolHealthProgramDashboardModel extends BaseScreenState<SchoolHealthProgramDashboardModel> {
  const SchoolHealthProgramDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchoolHealthProgramDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchoolHealthProgramDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
