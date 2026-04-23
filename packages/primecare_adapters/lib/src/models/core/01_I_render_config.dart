// Layer: 01_INFRASTRUCTURE

/// The runtime health status of a UI component or page.
enum RenderStatus {
  /// The component is operating within normal parameters.
  healthy,

  /// The component is rendering, but with performance or data issues.
  degraded,

  /// The component has failed to render or hydrate.
  failing,
}

/// Diagnostic configuration for how a screen should be rendered and recovered.
class RenderConfig {
  /// The current health status of the screen.
  final RenderStatus status;

  /// If true, a failure in this screen triggers a platform-wide recovery path.
  final bool isCritical;

  /// The route ID to redirect to if this screen fails.
  final String fallbackId;

  const RenderConfig({
    this.status = RenderStatus.healthy,
    this.isCritical = false,
    this.fallbackId = '/error-500',
  });

  /// Factory for creating a configuration from JSON.
  factory RenderConfig.fromJson(Map<String, dynamic> json) {
    return RenderConfig(
      status: RenderStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'healthy'),
        orElse: () => RenderStatus.healthy,
      ),
      isCritical: json['isCritical'] as bool? ?? false,
      fallbackId: json['fallbackId'] as String? ?? '/error-500',
    );
  }

  /// Converts the configuration to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'status': status.name,
      'isCritical': isCritical,
      'fallbackId': fallbackId,
    };
  }

  /// Creates a copy of this config with updated fields.
  RenderConfig copyWith({
    RenderStatus? status,
    bool? isCritical,
    String? fallbackId,
  }) {
    return RenderConfig(
      status: status ?? this.status,
      isCritical: isCritical ?? this.isCritical,
      fallbackId: fallbackId ?? this.fallbackId,
    );
  }
}
