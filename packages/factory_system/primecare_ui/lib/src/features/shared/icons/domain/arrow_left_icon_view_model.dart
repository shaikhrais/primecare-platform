// Layer: 02_MODELS_FOUNDATION
import 'package:primecare_ui/src/shared/src/models/view_model.dart';

class ArrowLeftIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ArrowLeftIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}
