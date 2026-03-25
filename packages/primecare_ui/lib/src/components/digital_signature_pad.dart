import 'package:flutter/material.dart';

class DigitalSignaturePad extends StatelessWidget {
  const DigitalSignaturePad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Draw Signature Here',
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
