import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PrimeWeeklyRosterCard extends StatelessWidget {
  final List<Widget> rosterNodes;

  const PrimeWeeklyRosterCard({
    super.key,
    required this.rosterNodes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Upcoming Roster", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
        const SizedBox(height: 12),
        PrimeCareCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: rosterNodes,
          ),
        ),
      ],
    );
  }
}
