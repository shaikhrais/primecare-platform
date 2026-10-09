import 'package:primecare_models/primecare_models.dart';

class HelpDeskDashboardModel extends BaseScreenState<HelpDeskDashboardModel> {
  const HelpDeskDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HelpDeskDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HelpDeskDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
