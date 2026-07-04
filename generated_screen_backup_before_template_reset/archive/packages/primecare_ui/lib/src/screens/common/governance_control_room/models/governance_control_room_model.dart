class GovernanceControlRoomModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const GovernanceControlRoomModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  GovernanceControlRoomModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return GovernanceControlRoomModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
