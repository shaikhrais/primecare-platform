class AppNotificationModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AppNotificationModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AppNotificationModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AppNotificationModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
