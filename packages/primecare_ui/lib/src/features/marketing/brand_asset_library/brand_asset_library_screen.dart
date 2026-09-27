import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/brand_asset_library_header_section.dart';
import 'sections/brand_asset_library_content_summary_section.dart';
import 'sections/brand_asset_library_primary_content_section.dart';
import 'sections/brand_asset_library_action_bar_section.dart';

class BrandAssetLibraryScreen extends StatelessWidget {
  const BrandAssetLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'brand_asset_library',
      title: 'Brand Asset Library',
      child: Column(
        children: const [
          const BrandAssetLibraryHeaderSection(),
          const BrandAssetLibraryContentSummarySection(),
          const BrandAssetLibraryPrimaryContentSection(),
          const BrandAssetLibraryActionBarSection(),
        ],
      ),
    );
  }
}
