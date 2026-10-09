// Governance - Category: view | Purpose: Layer: 02_MODELS_FOUNDATION
import 'primecare_view_model.dart';

// Layer: 02_MODELS_FOUNDATION

class ScheduleFacilityMaintenanceFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ScheduleFacilityMaintenanceFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}
