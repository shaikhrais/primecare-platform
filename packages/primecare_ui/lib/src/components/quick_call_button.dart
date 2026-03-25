import 'package:flutter/material.dart';

class QuickCallButton extends StatelessWidget {
  const QuickCallButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.videocam, color: Colors.green.shade600),
      ),
      onPressed: () {},
    );
  }
}
