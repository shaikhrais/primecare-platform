import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/adapter_providers.dart';
import 'stitch_engine/stitch_engine_renderer.dart';

class GenericFeatureScreen extends ConsumerWidget {
  final String featureId;
  const GenericFeatureScreen({super.key, required this.featureId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(adapterFeatureDataProvider(featureId));

    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            
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
                  
                  // Advanced Responsive Data Rendering via Stitch Engine Interpreter
                  Expanded(
                    child: asyncData.when(
                      loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF006565))),
                      error: (e, st) => Center(child: Text('Error loading $featureId: $e')),
                      data: (items) {
                        return StitchEngineRenderer(
                          featureId: featureId,
                          items: items,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        
        // Custom FAB equivalent
        Positioned(
          bottom: 16,
          right: 16,
          child: LayoutBuilder(builder: (context, constraints) {
            // Because Positioned constraints are passed from Stack, we check screen width via MediaQuery
            if (MediaQuery.of(context).size.width < 600) {
              return FloatingActionButton(key: const Key('data-status-id=shared-global-generic-action-1'), 
                backgroundColor: const Color(0xFF006565),
                onPressed: () {},
                child: const Icon(Icons.add, color: Colors.white),
              );
            }
            return const SizedBox.shrink();
          }),
        ),
      ],
    );
  }
}
