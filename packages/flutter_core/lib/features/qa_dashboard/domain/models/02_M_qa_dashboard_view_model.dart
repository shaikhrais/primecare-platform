// Layer: 02_MODELS_FOUNDATION
import 'package:primecare_core/00_B_flutter_core.dart';

class QaDashboardViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  QaDashboardViewModel({
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
