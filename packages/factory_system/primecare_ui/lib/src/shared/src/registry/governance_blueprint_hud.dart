import 'package:flutter_core/flutter_core.dart';

class GovernanceBlueprintHUD extends StatelessWidget {
  final dynamic intent;
  final Widget child;

  const GovernanceBlueprintHUD({
    super.key,
    required this.intent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
