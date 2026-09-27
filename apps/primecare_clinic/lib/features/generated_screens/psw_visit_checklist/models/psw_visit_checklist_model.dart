class PswVisitChecklistModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswVisitChecklistModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswVisitChecklistModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswVisitChecklistModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
