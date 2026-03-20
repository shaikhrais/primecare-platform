import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';

class PswLiveVideoTriageScreen extends StatefulWidget {
  final String incidentId;
  const PswLiveVideoTriageScreen({super.key, required this.incidentId});

  @override
  State<PswLiveVideoTriageScreen> createState() => _PswLiveVideoTriageScreenState();
}

class _PswLiveVideoTriageScreenState extends State<PswLiveVideoTriageScreen> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  bool _inCalling = false;
  MediaStream? _localStream;

  @override
  void initState() {
    super.initState();
    initRenderers();
  }

  Future<void> initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  @override
  void dispose() {
    _localStream?.dispose();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  Future<void> _openCamera() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'mandatory': {
          'minWidth': '1280', 
          'minHeight': '720',
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': [],
      }
    };

    try {
      final stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _localRenderer.srcObject = stream;
      setState(() {
        _inCalling = true;
        _localStream = stream;
      });
      // TODO: Negotiate SDP with Cloudflare WebSocket Router
    } catch (e) {
      debugPrint('[WEBRTC HARDWARE ERROR]: ${e.toString()}');
    }
  }

  Future<void> _hangUp() async {
    try {
      _localStream?.getTracks().forEach((track) {
        track.stop();
      });
      await _localStream?.dispose();
      _localRenderer.srcObject = null;
      setState(() {
        _inCalling = false;
      });
      if (mounted) context.pop();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark Theater Mode
      body: Stack(
        children: [
          // Remote Video Stream (Full Screen)
          Positioned.fill(
            child: Container(
              color: const Color(0xFF0F172A),
              child: _inCalling
                  ? RTCVideoView(
                      _remoteRenderer,
                      objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    )
                  : const Center(
                      child: Text('Awaiting Triage Nurse Assignment...', 
                        style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold)
                      ),
                    ),
            ),
          ),
          
          // Local Video Stream (PiP Matrix)
          if (_inCalling)
            Positioned(
              right: 20,
              top: 60, // Avoid safe area
              child: Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0x33FFFFFF), width: 1.5),
                  boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 20, offset: Offset(0, 10))],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: RTCVideoView(
                    _localRenderer,
                    mirror: true,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              ),
            ),

          // Glassmorphic Controls Dock
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: _buildControlsDock(),
          ),

          // Header Identity Badge
          Positioned(
            top: 60,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0x22FFFFFF)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8, height: 8,
                    decoration: BoxDecoration(color: _inCalling ? const Color(0xFF10B981) : Colors.amber, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text(_inCalling ? 'LIVE STREAMING' : 'CONNECTING', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildControlsDock() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0x11FFFFFF), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(Icons.mic, Colors.white, Colors.white24, () {}),
          if (!_inCalling)
            _buildControlButton(Icons.videocam, Colors.white, const Color(0xFF10B981), _openCamera)
          else
            _buildControlButton(Icons.call_end, Colors.white, const Color(0xFFE11D48), _hangUp),
          _buildControlButton(Icons.switch_camera, Colors.white, Colors.white24, () {}),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, Color iconColor, Color bgColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60, height: 60,
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 28),
      ),
    );
  }
}
