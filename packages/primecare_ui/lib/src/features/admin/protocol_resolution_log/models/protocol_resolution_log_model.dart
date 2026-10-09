import 'package:primecare_models/primecare_models.dart';

class ProtocolResolutionLogModel extends BaseScreenState<ProtocolResolutionLogModel> {
  const ProtocolResolutionLogModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ProtocolResolutionLogModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ProtocolResolutionLogModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
