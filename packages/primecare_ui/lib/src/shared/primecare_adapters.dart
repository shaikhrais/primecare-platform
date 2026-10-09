// Governance - Category: adapter | Purpose: Base class for all ViewModels in the PrimeCare UI Factory. Provides standardized properties for state management and ...
import 'package:flutter_core/flutter_core.dart';

export 'package:primecare_models/src/models/primecare_view_model.dart';

/// A base adapter for binding UI to data sources with resilience.
abstract class BindingAdapter<T> {
  Future<Result<T>> getData();
}
