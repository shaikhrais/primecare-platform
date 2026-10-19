import 'package:primecare_models/primecare_models.dart';

class AppNotificationModel extends BaseScreenState<AppNotificationModel> {
  const AppNotificationModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AppNotificationModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AppNotificationModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
