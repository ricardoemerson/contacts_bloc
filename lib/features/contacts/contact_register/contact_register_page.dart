import 'package:flutter/material.dart';

class ContactRegisterPage extends StatelessWidget {
  const ContactRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContactRegisterPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ContactRegisterPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
