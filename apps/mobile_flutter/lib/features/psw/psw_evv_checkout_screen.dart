import 'package:flutter/material.dart';
import '../../core/colors.dart';
import 'package:flutter/services.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswEvvCheckoutScreen extends StatefulWidget {
  const PswEvvCheckoutScreen({super.key});

  @override
  State<PswEvvCheckoutScreen> createState() => _PswEvvCheckoutScreenState();
}

class _PswEvvCheckoutScreenState extends State<PswEvvCheckoutScreen> {
  final List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      body: PrimeCareSafeArea(
        child: PrimeCarePadding(
          padding: const EdgeInsets.all(24.0),
          child: PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // High Fidelity Validation Badge
              const PrimeCareIcon(Icons.verified_user_rounded, size: 80, color: PrimeCareColors.emerald),
              const SizedBox(height: 24),
              PrimeCareText(
                'Verification Complete', 
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: PrimeCareColors.emerald), 
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 12),
              const PrimeCareText(
                'All mandatory Schedule Tasks have been intercepted. Please provide client signature verification to officially break the EVV lock.', 
                textAlign: TextAlign.center, 
                style: TextStyle(color: Colors.black54, fontSize: 16, height: 1.5)
              ),
              
              const SizedBox(height: 40),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const PrimeCareText(
                    'CLIENT CONSENT SIGNATURE',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 1.2),
                   ),
                   if (_points.isNotEmpty)
                      OutlinedButton(
                          onPressed: () => setState(() => _points.clear()),
                          style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.redAccent)),
                          child: const Text('Clear', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold))
                      )
                ]
              ),
              const SizedBox(height: 12),
              
              // Genuine CustomPainter Signature Pad Integration replacing Placeholder Frame
              PrimeCareExpanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                       BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, spreadRadius: 1, offset: const Offset(0, 4))
                    ]
                  ),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                         _points.add(details.localPosition);
                      });
                    },
                    onPanEnd: (details) => setState(() => _points.add(null)),
                    child: Stack(
                      children: [
                        if (_points.isEmpty)
                          Center(
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                  Icon(Icons.draw_rounded, color: Colors.grey.shade300, size: 48),
                                  const SizedBox(height: 12),
                                  Text('Client must sign here using their finger', style: TextStyle(color: Colors.grey.shade500, fontSize: 16, fontWeight: FontWeight.w500)),
                               ]
                             )
                          ),
                        CustomPaint(
                           size: Size.infinite,
                           painter: SignaturePainter(_points),
                        ),
                      ]
                    )
                  )
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Termination Interaction
              PrimeCareButton(type: PrimeCareButtonType.primary, 
                onPressed: () {
                   HapticFeedback.heavyImpact();
                   // Pop multiple stacks representing completion of flow natively
                   Navigator.of(context).pop(); 
                },
                child: const PrimeCareText('SECURE CHECKOUT & END SHIFT', style: TextStyle(letterSpacing: 0.5)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  final List<Offset?> points;
  SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6.0;

    for (int i = 0; i < points.length - 1; i++) {
        if (points[i] != null && points[i+1] != null) {
             canvas.drawLine(points[i]!, points[i+1]!, paint);
        }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => true;
}
