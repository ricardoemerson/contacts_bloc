import 'package:flutter/material.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ContactsListPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
