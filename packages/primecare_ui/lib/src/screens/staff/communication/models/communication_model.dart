import 'package:primecare_models/primecare_models.dart';

class CommunicationModel extends BaseScreenState<CommunicationModel> {
  const CommunicationModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CommunicationModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CommunicationModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
