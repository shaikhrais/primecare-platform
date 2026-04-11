import 'package:flutter/material.dart';

class PrimeCareMapCoordinate {
  final double latitude;
  final double longitude;

  const PrimeCareMapCoordinate({
    required this.latitude,
    required this.longitude,
  });
}

class PrimeCareMapMarker {
  final String id;
  final String label;
  final PrimeCareMapCoordinate coordinate;
  final IconData icon;
  final Color color;

  const PrimeCareMapMarker({
    required this.id,
    required this.label,
    required this.coordinate,
    this.icon = Icons.location_on,
    this.color = Colors.red,
  });
}

class LiveDispatchMap extends StatelessWidget {
  final PrimeCareMapCoordinate? center;
  final List<PrimeCareMapMarker> markers;
  final double initialZoom;
  final VoidCallback? onMapTap;

  const LiveDispatchMap({
    super.key,
    this.center,
    this.markers = const [],
    this.initialZoom = 12.0,
    this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMapTap,
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blueGrey.shade300),
        ),
        child: Stack(
          children: [
            // Structural placeholder for a real Map rendering engine
            // like google_maps_flutter, rendering relative points.
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.map, size: 60, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    'Center: ${center?.latitude.toStringAsFixed(4) ?? 'Live'} / ${center?.longitude.toStringAsFixed(4) ?? 'GPS'}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            // Mock projection of markers
            if (markers.isNotEmpty)
              ...markers.asMap().entries.map((entry) {
                // Highly abstracted mocked coordinates relative to center
                final index = entry.key;
                final marker = entry.value;
                return Positioned(
                  top: 50.0 + (index * 40),
                  left: 100.0 + (index * 60),
                  child: Column(
                    children: [
                      Icon(marker.icon, color: marker.color, size: 32),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          marker.label,
                          style: const TextStyle(color: Colors.white, fontSize: 8),
                        ),
                      )
                    ],
                  ),
                );
              }),

            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'LIVE DISPATCH | ${markers.length} UNITS',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
