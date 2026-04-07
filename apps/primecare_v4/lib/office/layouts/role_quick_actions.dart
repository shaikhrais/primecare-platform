import 'package:flutter/material.dart';
import 'provider_top_bar_config.dart';

class RoleQuickActionsMenu extends StatelessWidget {
  final String role;

  const RoleQuickActionsMenu({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final specificActions =
        ProviderTopBarConfig.roleSpecificQuickActions[role] ?? [];

    return PopupMenuButton<String>(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.add_circle, color: Colors.blueAccent),
          SizedBox(width: 4),
          Text('Quick Add', style: TextStyle(fontWeight: FontWeight.bold)),
          Icon(Icons.arrow_drop_down),
        ],
      ),
      onSelected: (value) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Triggered Action: $value')));
      },
      itemBuilder: (BuildContext context) {
        final List<PopupMenuEntry<String>> menuItems = [];

        // Add Common Actions
        for (var action in ProviderTopBarConfig.commonQuickActions) {
          menuItems.add(PopupMenuItem(value: action, child: Text(action)));
        }

        // Add Role Specific Actions if available
        if (specificActions.isNotEmpty) {
          menuItems.add(const PopupMenuDivider());
          menuItems.add(
            PopupMenuItem(
              enabled: false,
              child: Text(
                '\$role ACTIONS',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          );
          for (var action in specificActions) {
            menuItems.add(
              PopupMenuItem(
                value: action,
                child: Text(
                  action,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            );
          }
        }

        return menuItems;
      },
    );
  }
}
