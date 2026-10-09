import 'package:primecare_models/primecare_models.dart';

class PswNotificationsModel extends BaseScreenState<PswNotificationsModel> {
  const PswNotificationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswNotificationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswNotificationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
