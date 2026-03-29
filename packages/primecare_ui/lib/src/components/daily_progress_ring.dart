import 'package:flutter/material.dart';

class DailyProgressRing extends StatelessWidget {
  final double progress;
  const DailyProgressRing({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 10,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation(Theme.of(context).colorScheme.secondary),
          ),
          Center(
            child: Text('${(progress * 100).toInt()}%', overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
