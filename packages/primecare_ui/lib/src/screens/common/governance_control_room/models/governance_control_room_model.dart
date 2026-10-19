import 'package:primecare_models/primecare_models.dart';

class GovernanceControlRoomModel extends BaseScreenState<GovernanceControlRoomModel> {
  const GovernanceControlRoomModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GovernanceControlRoomModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GovernanceControlRoomModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
