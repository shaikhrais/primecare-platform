import 'package:primecare_models/primecare_models.dart';

class PublicHealthAlertBroadcasterModel extends BaseScreenState<PublicHealthAlertBroadcasterModel> {
  const PublicHealthAlertBroadcasterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PublicHealthAlertBroadcasterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PublicHealthAlertBroadcasterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
