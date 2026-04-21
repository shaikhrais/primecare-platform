// Layer: 05_UI_PRESENTATION
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_core/primecare_core.dart';

class AuraInteractiveSheet extends ConsumerStatefulWidget {
  const AuraInteractiveSheet({super.key});

  static Future<AuraIntent?> show(BuildContext context) {
    return showModalBottomSheet<AuraIntent>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AuraInteractiveSheet(),
    );
  }

  @override
  ConsumerState<AuraInteractiveSheet> createState() =>
      _AuraInteractiveSheetState();
}

class _AuraInteractiveSheetState extends ConsumerState<AuraInteractiveSheet>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(executionGateProvider)
          .passGate(
            ExecutionGateCategory.auraEngine,
            'Aura Interactive Sheet Opened: Requesting institutional context.',
          );
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auraIntent = ref.watch(auraIntentProvider);
    final suggestions = ref.read(auraCommandServiceProvider).getSuggestions();

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xE64F46E5), Color(0xE66366F1)], // 90% opacity
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Stack(
          children: [
            // Aura Wave Animation
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _waveController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _AuraWavePainter(progress: _waveController.value),
                  );
                },
              ),
            ),
            // Content Layer
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      const Icon(
                        LucideIcons.sparkles,
                        color: PrimeCareColors.white,
                        size: 28,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Ask Aura',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: PrimeCareColors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Conversational institutional synthesis at your fingertips.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: PrimeCareColors.white.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    onChanged: (val) =>
                        ref.read(auraQueryProvider.notifier).update(val),
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: PrimeCareColors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search or ask a question...',
                      hintStyle: TextStyle(
                        color: PrimeCareColors.white.withValues(alpha: 0.6),
                      ),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          LucideIcons.send,
                          color: PrimeCareColors.white,
                        ),
                        onPressed: () {
                          if (auraIntent != null &&
                              auraIntent.actions.isNotEmpty) {
                            ref
                                .read(executionGateProvider)
                                .passGate(
                                  ExecutionGateCategory.auraEngine,
                                  'Aura: Discovering intent: ${auraIntent.title}',
                                );
                            Navigator.pop(context, auraIntent);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_textController.text.isEmpty) ...[
                    Text(
                      'Suggestions',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: PrimeCareColors.white.withValues(alpha: 0.6),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: suggestions
                          .map(
                            (s) => _SuggestionChip(
                              label: s,
                              onTap: () {
                                _textController.text = s;
                                ref.read(auraQueryProvider.notifier).update(s);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ] else if (auraIntent != null) ...[
                    _IntentResultCard(intent: auraIntent),
                  ],
                  const Spacer(),
                  Center(
                    child: Text(
                      'Aura uses institutional context to generate actionable summaries.',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: PrimeCareColors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuraWavePainter extends CustomPainter {
  final double progress;

  _AuraWavePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          PrimeCareColors.white.withValues(alpha: 0.05),
          PrimeCareColors.white.withValues(alpha: 0.15),
          PrimeCareColors.white.withValues(alpha: 0.05),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final yOffset = size.height * 0.8;
    final wavelength = size.width * 1.5;
    final amplitude = 40.0;

    path.moveTo(0, yOffset);
    for (double i = 0; i <= size.width; i++) {
      final x = i;
      final y =
          yOffset +
          amplitude *
              math.sin(
                (progress * 2 * math.pi) + (i * 2 * math.pi / wavelength),
              );
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Second wave with different phase
    final path2 = Path();
    path2.moveTo(0, yOffset + 10);
    for (double i = 0; i <= size.width; i++) {
      final x = i;
      final y =
          (yOffset + 10) +
          (amplitude * 0.7) *
              math.sin(
                (progress * 2 * math.pi * 1.5) +
                    (i * 2 * math.pi / (wavelength * 0.8)),
              );
      path2.lineTo(x, y);
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(_AuraWavePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _SuggestionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SuggestionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Text(
          label,
          style: const TextStyle(color: PrimeCareColors.white, fontSize: 13),
        ),
      ),
    );
  }
}

class _IntentResultCard extends StatelessWidget {
  final AuraIntent intent;

  const _IntentResultCard({required this.intent});

  @override
  Widget build(BuildContext context) {
    final hasActions = intent.actions.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasActions ? LucideIcons.zap : LucideIcons.search,
                color: hasActions
                    ? const Color(0xFF4ADE80)
                    : PrimeCareColors.white.withValues(alpha: 0.6),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  intent.title,
                  style: const TextStyle(
                    color: PrimeCareColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            intent.description,
            style: TextStyle(
              color: PrimeCareColors.white.withValues(alpha: 0.6),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          if (hasActions) ...[
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, intent),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4ADE80),
                  foregroundColor: const Color(0xFF1E293B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text('Execute Action'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
