import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

import '../theme/design_system.dart';

class PrimeCareTerritoryCoordinate {
  final double latitude;
  final double longitude;

  const PrimeCareTerritoryCoordinate({
    required this.latitude,
    required this.longitude,
  });
}

class PrimeCareTerritoryZone {
  final String id;
  final String name;
  final List<PrimeCareTerritoryCoordinate> boundary;
  final Color fillColor;

  const PrimeCareTerritoryZone({
    required this.id,
    required this.name,
    required this.boundary,
    this.fillColor = PrimeCareColors.skyBlue,
  });
}

class PrimeCareTerritoryMarker {
  final String id;
  final PrimeCareTerritoryCoordinate coordinate;
  final IconData icon;
  final Color color;
  final String? label;

  const PrimeCareTerritoryMarker({
    required this.id,
    required this.coordinate,
    this.icon = Icons.location_history,
    this.color = PrimeCareColors.skyBlue,
    this.label,
  });
}

class PrimeCareTerritoryMap extends StatelessWidget {
  final double height;
  final String title;
  final List<PrimeCareTerritoryZone> zones;
  final List<PrimeCareTerritoryMarker> markers;
  final PrimeCareTerritoryCoordinate? center;

  const PrimeCareTerritoryMap({
    super.key,
    this.height = 300,
    this.title = '',
    this.zones = const [],
    this.markers = const [],
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(PrimeCareSpacing.md),
      decoration: BoxDecoration(
        color: PrimeCareDesignSystem.surfaceElevated,
        borderRadius: PrimeCareRadii.boardLg,
        border: Border.all(color: PrimeCareDesignSystem.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: PrimeCareSpacing.md),
          ],
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9), // Slate 100 for map bg
                borderRadius: PrimeCareRadii.boardSm,
                border: Border.all(color: PrimeCareDesignSystem.borderSubtle),
              ),
              child: Stack(
                children: [
                  // Abstract map representation
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 48,
                          color: PrimeCareDesignSystem.textMuted.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        const SizedBox(height: PrimeCareSpacing.sm),
                        Text(
                          'Territory Map Rendering Engine\nZones: ${zones.length} | Markers: ${markers.length}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: PrimeCareDesignSystem.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Mock projection of markers
                  if (markers.isNotEmpty)
                    ...markers.asMap().entries.map((entry) {
                      final index = entry.key;
                      final marker = entry.value;
                      return Positioned(
                        top: 20.0 + (index * 30),
                        left: 20.0 + (index * 50),
                        child: Column(
                          children: [
                            Icon(marker.icon, color: marker.color, size: 24),
                            if (marker.label != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: PrimeCareColors.black.withValues(
                                    alpha: 0.54,
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  marker.label!,
                                  style: const TextStyle(
                                    color: PrimeCareColors.white,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
