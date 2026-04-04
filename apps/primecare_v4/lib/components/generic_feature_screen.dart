
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dynamic_page_providers.dart';
import '../office/components/glass_surface.dart';

class GenericFeatureScreen extends ConsumerWidget {
  final String featureId;
  const GenericFeatureScreen({super.key, required this.featureId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(dynamicPageProvider(featureId));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1100;
          
          final double horizontalPadding = isMobile ? 16.0 : 24.0;
          
          return Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        featureId.replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          fontSize: isMobile ? 22 : 28, 
                          fontWeight: FontWeight.bold, 
                          color: const Color(0xFF006565),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    if (!isMobile)
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006565),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('New Entry'),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Advanced Responsive Data Rendering
                Expanded(
                  child: asyncData.when(
                    loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF006565))),
                    error: (e, st) => Center(child: Text('Error loading $featureId: $e')),
                    data: (items) {
                      if (items.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open, size: 64, color: Colors.blueGrey.withValues(alpha: 0.5)),
                              const SizedBox(height: 16),
                              const Text('No records found.', style: TextStyle(color: Colors.blueGrey, fontSize: 16)),
                            ],
                          ),
                        );
                      }
                      
                      if (isMobile) {
                        // Mobile: Vertical Card List
                        return ListView.separated(
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) => _buildMobileCard(items[index]),
                        );
                      } else {
                        // Desktop/Tablet: Responsive Grid of Premium Cards
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
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return FloatingActionButton(
            backgroundColor: const Color(0xFF006565),
            onPressed: () {},
            child: const Icon(Icons.add, color: Colors.white),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _buildMobileCard(Map<String, dynamic> item) {
    return GlassSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.teal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.analytics, color: Colors.teal, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['title'] ?? 'Record Data', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text('ID: ${item['id'] ?? 'SYS-UNK'}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item['status'] ?? 'Active', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGridCard(Map<String, dynamic> item) {
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
                decoration: BoxDecoration(color: Colors.teal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.auto_awesome_mosaic, color: Colors.teal, size: 26),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item['status'] ?? 'ACTIVE',
                  style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const Spacer(),
          Text(item['title'] ?? 'System Entity', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Colors.black87)),
          const SizedBox(height: 8),
          Text(
            item['description'] ?? 'No extended metadata available for this highly secured node object block.',
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
              Text('REF: ${item['id'] ?? '0x00'}', style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
              TextButton(
                onPressed: () {},
                child: const Text('View Module'),
              )
            ],
          )
        ],
      ),
    );
  }
}
