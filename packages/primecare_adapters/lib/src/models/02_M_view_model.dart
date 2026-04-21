// Layer: 02_MODELS_FOUNDATION
import 'package:equatable/equatable.dart';

/// Base class for all high-fidelity ViewModels.
/// Enforces Equality for efficient Riverpod rebuilds and state management.
abstract class PrimeCareViewModel extends Equatable {
  final bool isOfflineFallback;
  final String? version;

  const PrimeCareViewModel({
    this.isOfflineFallback = false,
    this.version,
  });

  @override
  List<Object?> get props => [isOfflineFallback, version];
}
