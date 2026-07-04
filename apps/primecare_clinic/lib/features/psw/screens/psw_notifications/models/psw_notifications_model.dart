class PswNotificationsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswNotificationsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswNotificationsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswNotificationsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
