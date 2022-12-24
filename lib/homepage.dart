import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _localRenderer = RTCVideoRenderer();

  @override
  void dispose() {
    _localRenderer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initializeRenderer();
    getUserMedia();
    super.initState();
  }

  void initializeRenderer() async {
    await _localRenderer.initialize();
  }

  void getUserMedia() async {
    final Map<String, dynamic> constraints = {
      'audio': true,
      'video': {'facingMode': 'user'}
    };
    MediaStream stream = await navigator.mediaDevices.getUserMedia(constraints);
    setState(() {
      _localRenderer.srcObject = stream;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: RTCVideoView(
              _localRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              mirror: true,
            ),
          ),
        ],
      ),
    );
  }
}
