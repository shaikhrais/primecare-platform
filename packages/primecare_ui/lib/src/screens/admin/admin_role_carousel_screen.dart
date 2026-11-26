import 'package:flutter/material.dart';
import 'package:primecare_runtime/src/localization/live_screen_text.dart';

import '../../localization/admin_role_carousel_catalog.dart';
import '../../localization/admin_registered_inventory_text.dart';
import 'admin_registered_inventory.dart';

class AdminRoleCarouselScreen extends StatelessWidget {
  const AdminRoleCarouselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    String label(String key) => liveScreenText(
      context, 'admin_role_carousel', locale, key,
      adminRoleCarouselCatalog[locale]?[key] ?? adminRoleCarouselCatalog['en']![key]!,
    );
    return AdminRegisteredInventory(
      title: label('title'),
      hint: label('search'),
      reload: label('reload'),
      carousel: true,
      roleFilter: true,
      unavailable: AdminRegisteredInventoryText.resolve(locale, 'carouselGap'),
    );
  }
}
