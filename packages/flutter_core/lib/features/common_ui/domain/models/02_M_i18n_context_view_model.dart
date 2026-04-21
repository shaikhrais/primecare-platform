// Layer: 02_MODELS_FOUNDATION
import 'package:primecare_core/00_B_flutter_core.dart';

class I18nContextViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  I18nContextViewModel({
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
