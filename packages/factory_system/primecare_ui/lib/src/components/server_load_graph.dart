import 'package:flutter/material.dart';

class ServerLoadGraph extends StatelessWidget {
  const ServerLoadGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      color: Colors.black,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          20,
          (index) => Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: (index * 7) % 80 + 20,
              color: Colors.greenAccent,
            ),
          ),
        ),
      ),
    );
  }
}
