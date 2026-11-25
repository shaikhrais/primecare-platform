import 'package:primecare_master/assets.dart' as assets;
import 'package:primecare_master/components.dart' as components;
import 'package:primecare_master/dashboard.dart' as dashboard;
import 'package:primecare_master/data_controls.dart' as data;
import 'package:primecare_master/navigation.dart' as navigation;
import 'package:primecare_master/layout.dart' as layout;

/// Compile-time verification through the public master package only.
List<Type> get masterComponentTypes => [
  assets.PrimeOriginalAsset,
  components.PrimeComponentKit,
  dashboard.PrimeChart,
  data.PrimeDataKit,
  navigation.PrimeWorkspaceNavigation,
  layout.WorkspaceLayout,
];
