// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_core/providers/03_D_portal_providers.dart';
import 'package:primecare_ui/src/design_system/01_I_clinical_glass.dart';
import 'package:primecare_ui/src/theme/01_I_design_system.dart';

enum StitchLayoutMode { grid, list, telemetry, form, unknown }

class FeatureViewModel {
  final String id;
  final String title;
  final String description;
  final String status;

  const FeatureViewModel({
    required this.id,
    required this.title,
    this.description = '',
    this.status = 'Development',
  });
}

class StitchEngineRenderer extends ConsumerWidget {
  final String featureId;
  final List<FeatureViewModel> items;

  const StitchEngineRenderer({
    super.key,
    required this.featureId,
    required this.items,
  });

  StitchLayoutMode _determineLayoutMode() {
    if (featureId.contains('telemetry') ||
        featureId.contains('monitor') ||
        featureId.contains('vital')) {
      return StitchLayoutMode.telemetry;
    }
    if (featureId.contains('form') || featureId.contains('auth')) {
      return StitchLayoutMode.form;
    }
    return StitchLayoutMode.grid;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);

    if (items.isEmpty) {
      return _buildEmptyState(ds, scale);
    }

    final mode = _determineLayoutMode();
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (mode == StitchLayoutMode.telemetry) {
      return _buildTelemetryLayout(isMobile, ds, scale);
    }
    if (mode == StitchLayoutMode.form) {
      return _buildFormLayout(isMobile, ds, scale);
    }

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items.asMap().entries.expand((entry) {
          final index = entry.key;
          final item = entry.value;
          return [
            KeyedSubtree(
              key: ValueKey(
                'stitch_list_${featureId}_${item.id}_${index}_$scale',
              ),
              child: _buildListCard(item, ds, scale),
            ),
            SizedBox(height: 12 * scale),
          ];
        }).toList(),
      );
    } else {
      final screenWidth = MediaQuery.of(context).size.width;
      final isTablet = screenWidth < 1200;
      final crossAxisCount = screenWidth < 600 ? 1 : (isTablet ? 2 : 3);

      // Calculate item width accounting for padding and spacing
      final horizontalPadding = isMobile ? 32.0 : (isTablet ? 48.0 : 80.0);
      final effectiveWidth = (screenWidth - horizontalPadding).clamp(
        200.0,
        double.infinity,
      );
      final itemWidth =
          (effectiveWidth - (crossAxisCount - 1) * 16 * scale) / crossAxisCount;

      return Wrap(
        spacing: 16 * scale,
        runSpacing: 16 * scale,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return KeyedSubtree(
            key: ValueKey(
              'stitch_grid_${featureId}_${item.id}_${index}_$scale',
            ),
            child: SizedBox(
              width: itemWidth > 0 ? itemWidth : 200, // Safety fallback
              child: _buildGridCard(item, ds, scale),
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildEmptyState(PrimeCareDesignSystem ds, double scale) {
    debugPrint(
      '[StitchEngineRenderer] FeatureId: $featureId, Items: ${items.length}',
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hub_outlined,
            size: 64 * scale,
            color: ds.colors.textTertiary.withValues(alpha: 0.5),
          ),
          SizedBox(height: 16 * scale),
          Text(
            'No UI-bound Data Adapters available.',
            style: GoogleFonts.inter(
              color: ds.colors.textTertiary,
              fontSize: 16 * scale,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryLayout(
    bool isMobile,
    PrimeCareDesignSystem ds,
    double scale,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16 * scale),
          child: ClinicalGlass(
            padding: EdgeInsets.all(16 * scale),
            child: Row(
              children: [
                Icon(
                  Icons.monitor_heart,
                  color: ds.colors.danger,
                  size: 32 * scale,
                ),
                SizedBox(width: 16 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 16 * scale,
                          color: ds.colors.textPrimary,
                        ),
                      ),
                      Text(
                        'Stream Active - ${item.id}',
                        style: GoogleFonts.inter(
                          color: ds.colors.textSecondary,
                          fontSize: 12 * scale,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12 * scale,
                    vertical: 6 * scale,
                  ),
                  decoration: BoxDecoration(
                    color: ds.colors.danger.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16 * scale),
                  ),
                  child: Text(
                    'LIVE',
                    style: GoogleFonts.inter(
                      color: ds.colors.danger,
                      fontWeight: FontWeight.bold,
                      fontSize: 10 * scale,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormLayout(
    bool isMobile,
    PrimeCareDesignSystem ds,
    double scale,
  ) {
    return ClinicalGlass(
      padding: EdgeInsets.all(24 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Dynamic Data Entry',
            style: GoogleFonts.inter(
              fontSize: 20 * scale,
              fontWeight: FontWeight.bold,
              color: ds.colors.textPrimary,
            ),
          ),
          SizedBox(height: 24 * scale),
          TextFormField(
            style: TextStyle(color: ds.colors.textPrimary),
            decoration: InputDecoration(
              labelText: 'Primary Input',
              labelStyle: TextStyle(color: ds.colors.textSecondary),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ds.colors.borderSubtle),
              ),
            ),
          ),
          SizedBox(height: 16 * scale),
          TextFormField(
            style: TextStyle(color: ds.colors.textPrimary),
            decoration: InputDecoration(
              labelText: 'Secondary Details',
              labelStyle: TextStyle(color: ds.colors.textSecondary),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ds.colors.borderSubtle),
              ),
            ),
          ),
          SizedBox(height: 24 * scale),
          ElevatedButton(
            key: Key('data-submit-${featureId}_$scale'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ds.colors.primary,
              foregroundColor: ds.colors.textPrimary,
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
            ),
            onPressed: () {},
            child: Text(
              'Submit Record',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard(
    FeatureViewModel item,
    PrimeCareDesignSystem ds,
    double scale,
  ) {
    return ClinicalGlass(
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10 * scale),
                decoration: BoxDecoration(
                  color: ds.colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8 * scale),
                ),
                child: Icon(
                  Icons.analytics,
                  color: ds.colors.primary,
                  size: 22 * scale,
                ),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 15 * scale,
                        color: ds.colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      'ID: ${item.id}',
                      style: GoogleFonts.inter(
                        color: ds.colors.textTertiary,
                        fontSize: 12 * scale,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.status,
                style: GoogleFonts.inter(
                  color: ds.colors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13 * scale,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14 * scale,
                color: ds.colors.textTertiary.withValues(alpha: 0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridCard(
    FeatureViewModel item,
    PrimeCareDesignSystem ds,
    double scale,
  ) {
    debugPrint(
      '[StitchEngineRenderer] Rendering GridCard: ${item.id} (${item.title})',
    );
    return ClinicalGlass(
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12 * scale),
                decoration: BoxDecoration(
                  color: ds.colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                child: Icon(
                  Icons.auto_awesome_mosaic,
                  color: ds.colors.primary,
                  size: 26 * scale,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10 * scale,
                  vertical: 4 * scale,
                ),
                decoration: BoxDecoration(
                  color: ds.colors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20 * scale),
                ),
                child: Text(
                  item.status.toUpperCase(),
                  style: GoogleFonts.inter(
                    color: ds.colors.success,
                    fontSize: 10 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          Text(
            item.title,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w800,
              fontSize: 18 * scale,
              color: ds.colors.textPrimary,
              letterSpacing: -0.2 * scale,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            item.description,
            style: GoogleFonts.inter(
              color: ds.colors.textSecondary,
              fontSize: 13 * scale,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16 * scale),
          Divider(color: ds.colors.borderSubtle, thickness: 1 * scale),
          SizedBox(height: 8 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'REF: ${item.id}',
                style: GoogleFonts.inter(
                  color: ds.colors.textTertiary,
                  fontSize: 11 * scale,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5 * scale,
                ),
              ),
              TextButton(
                key: Key('data-view-${item.id}'),
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'View Payload',
                  style: GoogleFonts.inter(
                    fontSize: 12 * scale,
                    color: ds.colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
