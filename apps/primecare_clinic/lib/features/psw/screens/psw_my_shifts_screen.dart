// Governance - Category: view | Purpose: UI Screen component rendering the Psw My Shifts Screen workspace interface.
import 'package:flutter/material.dart';

class PswMyShiftsScreen extends StatefulWidget {
  const PswMyShiftsScreen({Key? key}) : super(key: key);

  @override
  State<PswMyShiftsScreen> createState() => _PswMyShiftsScreenState();
}

class _PswMyShiftsScreenState extends State<PswMyShiftsScreen> {
  bool _isClockedIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('My Shifts'), backgroundColor: Colors.teal),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              color: Colors.teal.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Current Status', style: TextStyle(fontSize: 16, color: Colors.teal)),
                      Text(_isClockedIn ? 'CLOCKED IN' : 'OFF DUTY', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _isClockedIn ? Colors.green : Colors.grey)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isClockedIn ? Colors.red : Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)
                    ),
                    onPressed: () {
                      setState(() {
                        _isClockedIn = !_isClockedIn;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isClockedIn ? 'Successfully Clocked In!' : 'Successfully Clocked Out!')));
                    },
                    child: Text(_isClockedIn ? 'CLOCK OUT' : 'CLOCK IN', style: const TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  Text('Upcoming Shifts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Card(child: ListTile(leading: Icon(Icons.event, color: Colors.teal), title: Text('Today: 8:00 AM - 4:00 PM'), subtitle: Text('South Wing - Acute Care'))),
                  Card(child: ListTile(leading: Icon(Icons.event, color: Colors.teal), title: Text('Tomorrow: 10:00 AM - 6:00 PM'), subtitle: Text('North Wing - Geriatrics'))),
                  Card(child: ListTile(leading: Icon(Icons.event, color: Colors.teal), title: Text('Friday: 8:00 AM - 4:00 PM'), subtitle: Text('East Wing - Rehab'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}