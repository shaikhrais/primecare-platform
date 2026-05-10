import 'package:equatable/equatable.dart';

/// Represents a multi-dimensional identifier for a device to prevent spoofing.
class DeviceFingerprint extends Equatable {
  final String uuid;
  final String model;
  final String osVersion;
  final String? manufacturer;
  final bool isPhysical;
  final Map<String, dynamic> metadata;

  const DeviceFingerprint({
    required this.uuid,
    required this.model,
    required this.osVersion,
    this.manufacturer,
    this.isPhysical = true,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [
    uuid,
    model,
    osVersion,
    manufacturer,
    isPhysical,
    metadata,
  ];

  /// Creates a hash representation for secure comparison.
  String toHash() {
    // In production, this would use a robust SHA-256 implementation
    return 'FP-${uuid.hashCode}-${model.hashCode}';
  }
}
