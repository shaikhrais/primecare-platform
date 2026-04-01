import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';

class MarketingOversightView extends StatelessWidget {
  const MarketingOversightView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Regional Marketing Oversight', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            const GlassSurface(padding: EdgeInsets.all(24), child: Text('High-fidelity marketing growth and ROI tracker for Franchise Owner...')),
          ],
        ),
      ),
    );
  }
}
