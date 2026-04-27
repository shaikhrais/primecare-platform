// Layer: 02_MODELS_FOUNDATION
import 'package:flutter_core/flutter_core.dart';

class Undo2IconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  Undo2IconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}
