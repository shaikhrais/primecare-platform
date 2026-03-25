import 'package:flutter/material.dart';

class ClientInboxScreen extends StatelessWidget {
  const ClientInboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secure Inbox'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Care Coordinator - Sarah'),
            subtitle: Text('Your upcoming visit details have been updated.'),
            trailing: Text('10:00 AM'),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.medical_services)),
            title: Text('Dr. Smith'),
            subtitle: Text('Please upload your latest prescriptions.'),
            trailing: Text('Yesterday'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Compose new message...')),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
