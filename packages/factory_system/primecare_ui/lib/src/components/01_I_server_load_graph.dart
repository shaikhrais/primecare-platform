// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';

class ServerLoadGraph extends StatelessWidget {
  const ServerLoadGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      color: PrimeCareColors.black,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          20,
          (index) => Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: (index * 7) % 80 + 20,
              color: PrimeCareColors.emerald,
            ),
          ),
        ),
      ),
    );
  }
}
