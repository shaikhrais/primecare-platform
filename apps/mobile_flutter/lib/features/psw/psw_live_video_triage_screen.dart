import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

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
      // WebRTC mapped globally to Serverless Node
      final _channel = WebSocketChannel.connect(Uri.parse('wss://primecare-api.itpro-mohammed.workers.dev/websocket?token=live_triage_session'));
      _channel.sink.add('{"action": "sdp_offer"}');
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
    return PrimeCareScaffold(
      backgroundColor: Colors.black, // Dark Theater Mode
      body: PrimeCareStack(
        children: [
          // Remote Video Stream (Full Screen)
          Positioned.fill(
            child: PrimeCareContainer(
              color: PrimeCareColors.radarDark,
              child: _inCalling
                  ? RTCVideoView(
                      _remoteRenderer,
                      objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    )
                  : PrimeCareCenter(
                      child: PrimeCareText('Awaiting Triage Nurse Assignment...', 
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
              child: PrimeCareCard(
                width: 120,
                height: 160,
                
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
            child: PrimeCareCard(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              
              child: PrimeCareRow(
                children: [
                  PrimeCareCard(child: const SizedBox.shrink(), width: 8, height: 8,
                    
                  ),
                  SizedBox(width: 8),
                  PrimeCareText(_inCalling ? 'LIVE STREAMING' : 'CONNECTING', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildControlsDock() {
    return PrimeCareCard(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      
      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(Icons.mic, Colors.white, Colors.white24, () {}),
          if (!_inCalling)
            _buildControlButton(Icons.videocam, Colors.white, PrimeCareColors.emerald, _openCamera)
          else
            _buildControlButton(Icons.call_end, Colors.white, PrimeCareColors.rose, _hangUp),
          _buildControlButton(Icons.switch_camera, Colors.white, Colors.white24, () {}),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, Color iconColor, Color bgColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: PrimeCareCard(
        width: 60, height: 60,
        
        child: PrimeCareIcon(icon, color: iconColor, size: 28),
      ),
    );
  }
}
