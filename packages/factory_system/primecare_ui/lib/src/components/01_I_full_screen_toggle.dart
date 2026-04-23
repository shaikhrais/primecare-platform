// Layer: 01_INFRASTRUCTURE_COMPONENTS
import 'package:primecare_ui/primecare_ui.dart';

/// Standardized Full Screen Toggle for Dashboards
class PrimeCareFullScreenToggle extends StatelessWidget {
  final bool isFullScreen;
  final VoidCallback onToggle;

  const PrimeCareFullScreenToggle({
    super.key,
    required this.isFullScreen,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    
    return IconButton(
      icon: Icon(
        isFullScreen ? LucideIcons.minimize2 : LucideIcons.maximize2,
        color: theme.colors.slateGray,
      ),
      tooltip: isFullScreen ? 'Exit Full Screen' : 'Enter Full Screen',
      onPressed: onToggle,
    );
  }
}
