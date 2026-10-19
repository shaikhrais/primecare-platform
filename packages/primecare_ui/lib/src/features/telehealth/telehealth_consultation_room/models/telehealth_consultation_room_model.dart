import 'package:primecare_models/primecare_models.dart';

class TelehealthConsultationRoomModel extends BaseScreenState<TelehealthConsultationRoomModel> {
  const TelehealthConsultationRoomModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TelehealthConsultationRoomModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TelehealthConsultationRoomModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
