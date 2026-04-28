// Layer: 02_MODELS_FOUNDATION
import 'package:primecare_ui/src/shared/src/models/view_model.dart';

class LeftSideLayout2ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  LeftSideLayout2ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}
