import 'package:primecare_master/assets.dart' as assets;
import 'package:primecare_master/components.dart' as components;
import 'package:primecare_master/dashboard.dart' as dashboard;
import 'package:primecare_master/data_controls.dart' as data;
import 'package:primecare_master/navigation.dart' as navigation;
import 'package:primecare_master/layout.dart' as layout;
import 'package:primecare_master/theme.dart' as theme;
import 'package:primecare_master/preferences.dart' as preferences;

/// Compile-time verification through the public master package only.
List<Type> get masterComponentTypes => [
  assets.PrimeOriginalAsset,
  components.PrimeComponentKit,
  dashboard.PrimeChart,
  data.PrimeDataKit,
  navigation.PrimeWorkspaceNavigation,
  layout.WorkspaceLayout,
  theme.PersonalTheme,
  preferences.PreferenceSyncClient,
];
