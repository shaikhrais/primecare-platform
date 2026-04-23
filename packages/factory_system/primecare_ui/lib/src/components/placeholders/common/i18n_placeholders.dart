// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/components/placeholders/base_placeholder.dart';

class I18ncontextPlaceholder extends BasePlaceholder {
  const I18ncontextPlaceholder({super.key, dynamic data})
    : super(name: 'I18ncontext', data: data);
}

class I18nproviderPlaceholder extends BasePlaceholder {
  const I18nproviderPlaceholder({super.key, dynamic data})
    : super(name: 'I18nprovider', data: data);
}

class Usei18nPlaceholder extends BasePlaceholder {
  const Usei18nPlaceholder({super.key, dynamic data})
    : super(name: 'Usei18n', data: data);
}

class LanguageswitcherPlaceholder extends BasePlaceholder {
  const LanguageswitcherPlaceholder({super.key, dynamic data})
    : super(name: 'Languageswitcher', data: data);
}
