import 'package:flutter_core/registry/platform_role.dart';

void main() {
  print("PlatformRole values:");
  for (var r in PlatformRole.values) {
    print("  ${r} -> name: ${r.name}, nameSnake: ${r.nameSnake}");
  }
}
