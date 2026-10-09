import 'package:primecare_models/primecare_models.dart';

class RnMessagingModel extends BaseScreenState<RnMessagingModel> {
  const RnMessagingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnMessagingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnMessagingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
