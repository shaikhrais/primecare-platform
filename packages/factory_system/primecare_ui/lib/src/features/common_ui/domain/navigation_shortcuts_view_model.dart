import 'package:primecare_ui/src/shared/primecare_adapters.dart';

// Layer: 02_MODELS_FOUNDATION

class NavigationShortcutsViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavigationShortcutsViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}
