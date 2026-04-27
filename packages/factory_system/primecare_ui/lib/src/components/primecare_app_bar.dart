// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

class PrimeCareAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const PrimeCareAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      backgroundColor:
          Colors.transparent, // Inherit Scaffold background passively
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      actions: actions,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: PrimeCareColors.radarDark,
        ),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
