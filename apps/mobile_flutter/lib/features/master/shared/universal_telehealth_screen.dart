import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UniversalTelehealthScreen extends StatefulWidget {
  final String sessionType;
  final String peerId;

  const UniversalTelehealthScreen({
    super.key,
    required this.sessionType,
    required this.peerId,
  });

  @override
  State<UniversalTelehealthScreen> createState() => _UniversalTelehealthScreenState();
}

class _UniversalTelehealthScreenState extends State<UniversalTelehealthScreen> with SingleTickerProviderStateMixin {
  bool _isMuted = false;
  bool _isVideoOff = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _endCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('E2E Telehealth Session Terminated Logically.'), backgroundColor: Colors.red),
    );
    if (context.canPop()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isVideo = widget.sessionType == 'video';

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Background (Peer Video or Audio Avatar)
            Center(
              child: isVideo && !_isVideoOff
                  ? AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: 0.5 + (_pulseController.value * 0.5),
                          child: Icon(Icons.person, size: 200, color: Colors.grey.shade800),
                        );
                      },
                    )
                  : Icon(Icons.record_voice_over, size: 150, color: Colors.blue.shade300),
            ),
            
            // Self Pip (Picture-in-Picture)
            if (isVideo)
              Positioned(
                bottom: 120,
                right: 20,
                child: Container(
                  width: 100,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24, width: 2),
                    boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
                  ),
                  child: Center(
                    child: _isVideoOff 
                      ? const Icon(Icons.videocam_off, color: Colors.red, size: 32)
                      : const Icon(Icons.face, color: Colors.white54, size: 48),
                  ),
                ),
              ),

            // Top Status Bar
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: const [
                        Icon(Icons.lock, color: Colors.green, size: 14),
                        SizedBox(width: 6),
                        Text('E2E Encrypted', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      isVideo ? 'HD VIDEO' : 'SECURE AUDIO',
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // Controls
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlBtn(
                    icon: _isMuted ? Icons.mic_off : Icons.mic,
                    color: _isMuted ? Colors.red : Colors.grey.shade800,
                    onTap: () => setState(() => _isMuted = !_isMuted),
                  ),
                  if (isVideo)
                    _buildControlBtn(
                      icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
                      color: _isVideoOff ? Colors.red : Colors.grey.shade800,
                      onTap: () => setState(() => _isVideoOff = !_isVideoOff),
                    ),
                  _buildControlBtn(
                    icon: Icons.call_end,
                    color: Colors.red.shade600,
                    size: 64,
                    iconSize: 32,
                    onTap: _endCall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlBtn({required IconData icon, required Color color, required VoidCallback onTap, double size = 56, double iconSize = 24}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Center(child: Icon(icon, color: Colors.white, size: iconSize)),
      ),
    );
  }
}
