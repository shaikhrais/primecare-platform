import 'package:flutter/material.dart';

import '../../localization/admin_registered_inventory_text.dart';
import 'admin_registered_inventory.dart';

class AdminScreenshotGalleryScreen extends StatelessWidget {
  const AdminScreenshotGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    String label(String key) => AdminRegisteredInventoryText.resolve(locale, key);
    return AdminRegisteredInventory(
      title: label('galleryTitle'),
      roleFilter: true,
      unavailable: label('galleryGap'),
    );
  }
}
