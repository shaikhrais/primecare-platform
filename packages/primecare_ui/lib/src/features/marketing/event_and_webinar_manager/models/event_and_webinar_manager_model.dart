import 'package:primecare_models/primecare_models.dart';

class EventAndWebinarManagerModel extends BaseScreenState<EventAndWebinarManagerModel> {
  const EventAndWebinarManagerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  EventAndWebinarManagerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => EventAndWebinarManagerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
