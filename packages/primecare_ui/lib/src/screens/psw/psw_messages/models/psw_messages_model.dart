import 'package:primecare_models/primecare_models.dart';

class PswMessagesModel extends BaseScreenState<PswMessagesModel> {
  const PswMessagesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswMessagesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswMessagesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
