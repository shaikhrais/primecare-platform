// Layer: 01_INFRASTRUCTURE

/// Configuration for the platform's resilience and recovery behavior.
class ResilienceConfig {
  /// If false, the platform will use standard Flutter error handling
  /// instead of the branded "Recovery Mode" UI.
  static bool enableRecoveryModeUI = true;

  /// If true, the Recovery Mode screen will display the full exception
  /// and stack trace for rapid diagnostics.
  static bool showDebugDetailsInRecovery =
      true; // Enabled for "Full Trail" as requested

  /// If true, the platform will attempt to mechanically fix itself by
  /// resetting state before showing the recovery UI.
  static bool enableAutoHealing = true;

  /// Maximum number of automated reset attempts before requiring manual intervention.
  static int maxAutoResets = 3;
}
