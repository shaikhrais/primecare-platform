class FamilyCareUpdatesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FamilyCareUpdatesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FamilyCareUpdatesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FamilyCareUpdatesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
