import 'package:primecare_models/primecare_models.dart';

class SecureMessageCenterModel extends BaseScreenState<SecureMessageCenterModel> {
  const SecureMessageCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SecureMessageCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SecureMessageCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
