import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrimeCareActionItem {
  final String title;
  final IconData icon;
  final String route;
  final Color? color;

  const PrimeCareActionItem({
    required this.title,
    required this.icon,
    required this.route,
    this.color,
  });
}

class PrimeCareQuickActionsGrid extends StatelessWidget {
  final List<PrimeCareActionItem> actions;
  final String sectionTitle;

  const PrimeCareQuickActionsGrid({
    super.key,
    required this.actions,
    this.sectionTitle = 'Quick Actions',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            sectionTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 600;
            return Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: actions.map((action) {
                final btnWidth = isDesktop
                    ? (constraints.maxWidth - (16.0 * (actions.length - 1))) /
                          actions.length
                    : constraints.maxWidth;

                return SizedBox(
                  width: btnWidth,
                  height: 64,
                  child: ElevatedButton.icon(
                    onPressed: () => context.push(action.route),
                    icon: Icon(action.icon, color: Colors.white),
                    label: Text(
                      action.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          action.color ?? const Color(0xFF1E88E5), // Base Blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
