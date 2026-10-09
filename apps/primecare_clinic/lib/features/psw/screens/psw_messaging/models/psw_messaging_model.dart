import 'package:primecare_models/primecare_models.dart';

class PswMessagingModel extends BaseScreenState<PswMessagingModel> {
  const PswMessagingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswMessagingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswMessagingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
