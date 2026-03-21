import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CoordinatorLiveMapScreen extends StatefulWidget {
  const CoordinatorLiveMapScreen({super.key});

  @override
  State<CoordinatorLiveMapScreen> createState() => _CoordinatorLiveMapScreenState();
}

class _CoordinatorLiveMapScreenState extends State<CoordinatorLiveMapScreen> {
  // Center of Toronto
  final LatLng _mapCenter = const LatLng(43.651070, -79.347015);
  final MapController _mapController = MapController();
  
  // Simulated Haversine Active Worker Nodes
  final List<WorkerMarker> _activeWorkers = [
    WorkerMarker(id: 'w1', position: const LatLng(43.661070, -79.357015), role: 'RN', active: true),
    WorkerMarker(id: 'w2', position: const LatLng(43.641070, -79.337015), role: 'PSW', active: true),
    WorkerMarker(id: 'w3', position: const LatLng(43.631070, -79.367015), role: 'PSW', active: true, surge: true),
    WorkerMarker(id: 'w4', position: const LatLng(43.671070, -79.327015), role: 'RN', active: true),
  ];

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimeCareNavBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: PrimeCareCard(
          margin: const EdgeInsets.all(8),
          
          child: IconButton(
            icon: const PrimeCareIcon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
        ),
        title: PrimeCareCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          
          child: const PrimeCareText('Live Dispatch Radar', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: PrimeCareStack(
        children: [
          // Native Flutter Map Layer
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _mapCenter,
              initialZoom: 13.0,
              interactionOptions: const InteractionOptions(flags: InteractiveFlag.all),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', // Dark Theme Map tiles
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.primecare.mobile',
              ),
              MarkerLayer(
                markers: _activeWorkers.map((worker) => Marker(
                  point: worker.position,
                  width: 50,
                  height: 50,
                  child: _buildRadarBlip(worker),
                )).toList(),
              ),
              // Simulated Haversine Active Zone (15km radius boundary)
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: _mapCenter,
                    color: const Color(0x1110B981),
                    borderColor: const Color(0x6610B981),
                    borderStrokeWidth: 2,
                    useRadiusInMeter: true,
                    radius: 5000, // 5km radius visually
                  )
                ]
              )
            ],
          ),
          
          // Command Center HUD
          Positioned(
            left: 20,
            right: 20,
            bottom: 40,
            child: AnimationLimiter(
              child: PrimeCareColumn(
                mainAxisSize: MainAxisSize.min,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 600),
                  childAnimationBuilder: (widget) => SlideAnimation(verticalOffset: 50, child: FadeInAnimation(child: widget)),
                  children: [
                    _buildDispatchHUD(),
                  ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRadarBlip(WorkerMarker worker) {
    final bool isRN = worker.role == 'RN';
    final Color markerColor = isRN ? const Color(0xFF0EA5E9) : PrimeCareColors.emerald;
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: PrimeCareText('${worker.role} Unit ${worker.id} Selected. Establishing Comms...'),
          backgroundColor: PrimeCareColors.radarDark,
          action: SnackBarAction(label: 'PING', textColor: markerColor, onPressed: (){}),
        ));
        _mapController.move(worker.position, 15.0);
      },
      child: PrimeCareStack(
        alignment: Alignment.center,
        children: [
          PrimeCareCard(
            width: 50, height: 50,
            
          ),
          PrimeCareCard(
            width: 20, height: 20,
            
          ),
          if (worker.surge)
            Positioned(top: -5, right: -5, child: const PrimeCareIcon(Icons.bolt, color: Colors.amber, size: 24))
        ],
      ),
    );
  }

  Widget _buildDispatchHUD() {
    return PrimeCareCard(
      padding: const EdgeInsets.all(20),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const PrimeCareText('Live Dispatch Array', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              PrimeCareCard(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                
                child: const PrimeCareText('STATUS: ACQUIRING', style: TextStyle(color: PrimeCareColors.emerald, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
              )
            ],
          ),
          const PrimeCareSizedBox(height: 16),
          PrimeCareRow(
            children: [
              PrimeCareExpanded(child: _buildHUDSemantic('Available Workers', '4 Units', Icons.people_outline)),
              const PrimeCareSizedBox(width: 12),
              PrimeCareExpanded(child: _buildHUDSemantic('Critical Alerts', '0', Icons.warning_amber_rounded)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildHUDSemantic(String label, String val, IconData icon) {
    return PrimeCareCard(
      padding: const EdgeInsets.all(12),
      
      child: PrimeCareRow(
        children: [
          PrimeCareIcon(icon, color: Colors.white70, size: 24),
          const PrimeCareSizedBox(width: 12),
          PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareText(val, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              PrimeCareText(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}

class WorkerMarker {
  final String id;
  final LatLng position;
  final String role;
  final bool active;
  final bool surge;
  WorkerMarker({required this.id, required this.position, required this.role, required this.active, this.surge = false});
}
