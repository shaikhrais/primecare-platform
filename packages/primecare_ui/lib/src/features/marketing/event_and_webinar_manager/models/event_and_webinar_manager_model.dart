class EventAndWebinarManagerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const EventAndWebinarManagerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  EventAndWebinarManagerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return EventAndWebinarManagerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
