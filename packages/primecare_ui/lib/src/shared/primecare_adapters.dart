// Governance - Category: adapter | Purpose: Base class for all ViewModels in the PrimeCare UI Factory. Provides standardized properties for state management and ...
import 'package:equatable/equatable.dart';
import 'package:flutter_core/flutter_core.dart';

/// Base class for all ViewModels in the PrimeCare UI Factory.
/// Provides standardized properties for state management and resilience.
abstract class PrimeCareViewModel extends Equatable {
  final bool isOfflineFallback;

  const PrimeCareViewModel({this.isOfflineFallback = false});

  @override
  List<Object?> get props => [isOfflineFallback];

  Map<String, dynamic> toJson();
}

/// A base adapter for binding UI to data sources with resilience.
abstract class BindingAdapter<T> {
  Future<Result<T>> getData();
}
