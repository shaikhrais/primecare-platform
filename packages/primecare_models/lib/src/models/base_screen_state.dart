/// Common screen state storage. Existing null-as-unchanged copy behavior remains.
abstract class BaseScreenState<T extends BaseScreenState<T>> {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;
  const BaseScreenState({this.isLoading = false, this.errorMessage,
    this.data = const {}});

  T rebuild({required bool isLoading, required String? errorMessage,
    required Map<String, dynamic> data});

  T copyWith({bool? isLoading, String? errorMessage,
    Map<String, dynamic>? data}) => rebuild(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
}
