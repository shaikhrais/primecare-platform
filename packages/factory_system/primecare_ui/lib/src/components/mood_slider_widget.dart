// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

class MoodSliderWidget extends StatefulWidget {
  const MoodSliderWidget({super.key});
  @override
  _MoodSliderWidgetState createState() => _MoodSliderWidgetState();
}

class _MoodSliderWidgetState extends State<MoodSliderWidget> {
  double _val = 0.5;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          _val > 0.8
              ? Icons.sentiment_very_satisfied
              : _val > 0.4
              ? Icons.sentiment_neutral
              : Icons.sentiment_very_dissatisfied,
          size: 60,
          color: Colors.deepPurpleAccent,
        ),
        Slider(
          value: _val,
          onChanged: (v) => setState(() => _val = v),
          activeColor: Colors.deepPurpleAccent,
        ),
      ],
    );
  }
}

// Using dynamicPageProvider and ViewModel pattern for data binding.
