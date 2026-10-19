import 'package:primecare_models/primecare_models.dart';

class AiChatbotModel extends BaseScreenState<AiChatbotModel> {
  const AiChatbotModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AiChatbotModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AiChatbotModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
