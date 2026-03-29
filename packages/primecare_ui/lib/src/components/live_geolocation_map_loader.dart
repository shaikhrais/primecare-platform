import 'package:flutter/material.dart';

class LiveGeolocationMapLoader extends StatelessWidget {
  const LiveGeolocationMapLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Colors.green.shade600, size: 32),
            const SizedBox(height: 8),
            Text('0.2 miles from client', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(
                color: Colors.green.shade800,
                fontWeight: FontWeight.bold,),
            ),
          ],
        ),
      ),
    );
  }
}
