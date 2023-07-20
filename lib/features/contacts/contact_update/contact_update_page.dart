import 'package:flutter/material.dart';

class ContactUpdatePage extends StatelessWidget {
  const ContactUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContactUpdatePage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ContactUpdatePage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
