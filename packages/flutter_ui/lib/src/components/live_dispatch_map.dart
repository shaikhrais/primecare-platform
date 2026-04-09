import 'package:flutter/material.dart';

class LiveDispatchMap extends StatelessWidget {
  const LiveDispatchMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.blueGrey.shade100,
      child: Stack(
        children: [
          const Center(child: Icon(Icons.map, size: 60, color: Colors.white)),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(4),
              color: Colors.black54,
              child: const Text('LIVE MAP', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
