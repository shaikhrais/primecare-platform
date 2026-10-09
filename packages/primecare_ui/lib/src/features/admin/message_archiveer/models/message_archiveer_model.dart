import 'package:primecare_models/primecare_models.dart';

class MessageArchiveerModel extends BaseScreenState<MessageArchiveerModel> {
  const MessageArchiveerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MessageArchiveerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MessageArchiveerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
