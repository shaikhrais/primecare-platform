import 'package:flutter/material.dart';

import '../../localization/admin_reality_filter_text.dart';
import '../../localization/admin_registered_inventory_text.dart';
import 'admin_registered_inventory.dart';

class AdminRealityCheckScreen extends StatelessWidget {
  const AdminRealityCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    String label(String key) => AdminRealityFilterText.resolve(locale, key);
    return Semantics(
      label: 'admin_reality_check_screen',
      container: true,
      child: AdminRegisteredInventory(
        title: label('title'),
        hint: label('search'),
        reload: label('reload'),
        unavailable: AdminRegisteredInventoryText.resolve(locale, 'realityGap'),
      ),
    );
  }
}
