import 'package:flutter/material.dart';

class PswClientProfileScreen extends StatelessWidget {
  const PswClientProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Client Profile'), backgroundColor: Colors.teal),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(radius: 60, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11')),
                    const SizedBox(height: 16),
                    const Text('John Doe', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const Text('Room 402 - High Priority', style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.call),
                          label: const Text('Call Family'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.medical_services),
                          label: const Text('Alert RN'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(height: 48, thickness: 2),
              const Text('Medical History', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const ListTile(leading: Icon(Icons.favorite, color: Colors.red), title: Text('Hypertension'), subtitle: Text('Diagnosed 2018')),
              const ListTile(leading: Icon(Icons.visibility, color: Colors.blue), title: Text('Glaucoma'), subtitle: Text('Daily eye drops required')),
              const ListTile(leading: Icon(Icons.accessible), title: Text('Fall Risk'), subtitle: Text('Requires walker assistance')),
            ],
          ),
        ),
      ),
    );
  }
}