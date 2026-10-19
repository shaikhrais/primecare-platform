import 'package:primecare_models/primecare_models.dart';

class MessagingModel extends BaseScreenState<MessagingModel> {
  const MessagingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MessagingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MessagingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
