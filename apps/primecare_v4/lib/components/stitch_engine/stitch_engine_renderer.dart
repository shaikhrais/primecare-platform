import 'package:flutter/material.dart';
import '../../office/components/glass_surface.dart';
import '../../features/generic_feature/domain/models/feature_view_model.dart';

enum StitchLayoutMode { grid, list, telemetry, form, unknown }

class StitchEngineRenderer extends StatelessWidget {
  final String featureId;
  final List<FeatureViewModel> items;

  const StitchEngineRenderer({
    super.key,
    required this.featureId,
    required this.items,
  });

  StitchLayoutMode _determineLayoutMode() {
    if (featureId.contains('telemetry') || featureId.contains('monitor') || featureId.contains('vital')) {
      return StitchLayoutMode.telemetry;
    }
    if (featureId.contains('form') || featureId.contains('auth')) {
      return StitchLayoutMode.form;
    }
    return StitchLayoutMode.grid;
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _buildEmptyState();
    }

    final mode = _determineLayoutMode();
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (mode == StitchLayoutMode.telemetry) {
      return _buildTelemetryLayout(isMobile);
    }
    if (mode == StitchLayoutMode.form) {
      return _buildFormLayout(isMobile);
    }

    if (isMobile) {
      return ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _buildListCard(items[index]),
      );
    } else {
      final isTablet = MediaQuery.of(context).size.width < 1100;
      final crossAxisCount = isTablet ? 2 : 3;
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: isTablet ? 1.5 : 1.8,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => _buildGridCard(items[index]),
      );
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hub_outlined, size: 64, color: Colors.blueGrey.withOpacity(0.5)),
          const SizedBox(height: 16),
          const Text('No UI-bound Data Adapters available.', style: TextStyle(color: Colors.blueGrey, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildTelemetryLayout(bool isMobile) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: GlassSurface(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.monitor_heart, color: Colors.redAccent, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Stream Active - ${item.id}', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                  child: const Text('LIVE', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormLayout(bool isMobile) {
    return SingleChildScrollView(
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Dynamic Data Entry', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextFormField(decoration: const InputDecoration(labelText: 'Primary Input', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextFormField(decoration: const InputDecoration(labelText: 'Secondary Details', border: OutlineInputBorder())),
            const SizedBox(height: 24),
            ElevatedButton(key: const Key('data-status-id=shared-global-stitch-action-1'), 
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF006565), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: () {},
              child: const Text('Submit Record'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListCard(FeatureViewModel item) {
    return GlassSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.teal.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.analytics, color: Colors.teal, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text('ID: ${item.id}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.status, style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGridCard(FeatureViewModel item) {
    return GlassSurface(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.teal.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.auto_awesome_mosaic, color: Colors.teal, size: 26),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item.status,
                  style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const Spacer(),
          Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Colors.black87)),
          const SizedBox(height: 8),
          Text(
            item.description,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('REF: ${item.id}', style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
              TextButton(key: const Key('data-status-id=shared-global-stitch-action-2'), 
                onPressed: () {},
                child: const Text('View Payload'),
              )
            ],
          )
        ],
      ),
    );
  }
}
