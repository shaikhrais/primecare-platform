// Governance - Category: config | Purpose: Layer: 01_INFRASTRUCTURE Configuration for the platform's resilience and recovery behavior. If true, catastrophic fai...
// Layer: 01_INFRASTRUCTURE

/// Configuration for the platform's resilience and recovery behavior.
class ResilienceConfig {
  /// If true, catastrophic failures will attempt to restart the Flutter engine.
  static const bool enableAutoHealing = true;

  /// If true, a user-facing recovery screen is displayed upon crash.
  static const bool enableRecoveryModeUI = true;

  /// If true, the Recovery Mode screen will display the full exception
  /// and stack trace for rapid diagnostics.
  static bool showDebugDetailsInRecovery =
      true; // Enabled for "Full Trail" as requested

  /// Maximum number of automated reset attempts before requiring manual intervention.
  static int maxAutoResets = 3;
}
