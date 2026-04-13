abstract class OfflineFallbackState {
  /// Indicates whether the current state object was generated from
  /// mock/fallback data due to the system failing to connect to the live API or database.
  ///
  /// When [true], UI components should render distinct visual indicators
  /// (such as amber warning banners or colored tints) to inform the user
  /// that the data is not real-time.
  bool get isOfflineFallback;
}
