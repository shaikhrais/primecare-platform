import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';

class RmtNotesView extends StatelessWidget {
  const RmtNotesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text('RMT Assessment Notes', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            const GlassSurface(padding: EdgeInsets.all(24), child: Text('High-fidelity SOAP editor for RMT assessment...')),
          ],
        ),
      ),
    );
  }
}
