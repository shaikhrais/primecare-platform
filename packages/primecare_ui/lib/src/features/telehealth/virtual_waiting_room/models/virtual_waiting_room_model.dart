import 'package:primecare_models/primecare_models.dart';

class VirtualWaitingRoomModel extends BaseScreenState<VirtualWaitingRoomModel> {
  const VirtualWaitingRoomModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VirtualWaitingRoomModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VirtualWaitingRoomModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
