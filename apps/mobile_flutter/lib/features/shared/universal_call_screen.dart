import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:async';

class UniversalCallScreen extends StatefulWidget {
  final String rolePrefix;
  final String userId;

  const UniversalCallScreen({super.key, required this.rolePrefix, required this.userId});

  @override
  State<UniversalCallScreen> createState() => _UniversalCallScreenState();
}

class _UniversalCallScreenState extends State<UniversalCallScreen> with SingleTickerProviderStateMixin {
  late Timer _timer;
  int _elapsedSeconds = 0;
  bool _isMuted = false;
  bool _isSpeaker = true;
  
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _elapsedSeconds++);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  String get _formattedTime {
    final min = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final sec = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.primaryColor;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Blurred background
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&auto=format&fit=crop',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(color: Colors.black.withValues(alpha: 0.6)),
            ),
          ),
          
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Info
                Column(
                  children: [
                    const SizedBox(height: 48),
                    const Icon(Icons.enhanced_encryption_rounded, color: Colors.greenAccent, size: 24),
                    const SizedBox(height: 8),
                    const Text('End-to-End Encrypted VoIP', style: TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                    const SizedBox(height: 32),
                    Text('Active External Contact', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 28, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    Text(_formattedTime, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300)),
                  ],
                ),
                
                // Pulsing Avatar
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primary.withValues(alpha: 0.5 * _pulseController.value),
                            blurRadius: 40,
                            spreadRadius: 20 * _pulseController.value,
                          )
                        ]
                      ),
                      child: const CircleAvatar(
                        radius: 90,
                        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&auto=format&fit=crop'),
                      ),
                    );
                  }
                ),
                
                // Bottom Controls
                Container(
                  padding: const EdgeInsets.only(bottom: 64, left: 32, right: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildControlButton(
                        icon: _isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
                        label: 'Mute',
                        isActive: _isMuted,
                        onTap: () => setState(() => _isMuted = !_isMuted)
                      ),
                      
                      // End Call Button (Massive Red)
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 80, height: 80,
                          decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                          child: const Icon(Icons.call_end_rounded, color: Colors.white, size: 36),
                        ),
                      ),
                      
                      _buildControlButton(
                         icon: _isSpeaker ? Icons.volume_up_rounded : Icons.volume_down_rounded,
                         label: 'Speaker',
                         isActive: _isSpeaker,
                         onTap: () => setState(() => _isSpeaker = !_isSpeaker)
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildControlButton({required IconData icon, required String label, required bool isActive, required VoidCallback onTap}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isActive ? Colors.black87 : Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
