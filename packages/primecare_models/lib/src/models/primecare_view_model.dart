import 'package:equatable/equatable.dart';

/// Base class for all ViewModels in the PrimeCare UI Factory.
/// Provides standardized properties for state management and resilience.
abstract class PrimeCareViewModel extends Equatable {
  final bool isOfflineFallback;

  const PrimeCareViewModel({this.isOfflineFallback = false});

  @override
  List<Object?> get props => [isOfflineFallback];

  Map<String, dynamic> toJson();
}

