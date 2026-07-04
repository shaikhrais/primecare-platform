class VirtualWaitingRoomModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const VirtualWaitingRoomModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  VirtualWaitingRoomModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return VirtualWaitingRoomModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
